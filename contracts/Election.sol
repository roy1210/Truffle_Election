pragma solidity ^0.4.2;

contract Election {

  // Model a candidate
  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }

  //Store accounts that have voted
  mapping (address => bool) public voters;
  //Fetch a candidate (Read/write Candidates)
  mapping(uint => Candidate) public candidates;
  // Store candidates count
  uint public candidatesCount;

  //Voted event
  event votedEvent(
    uint indexed _candidateId
  );

  // Constructor
  function Election () public {
    addCandidate("Candidate 1");
    addCandidate("Candidate 2");
  }

  function addCandidate(string _name) private {
    candidatesCount ++;
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }

  function vote(uint _candidateId) public {
    // Require that they haven't voted before
    require(!voters[msg.sender]);

    //Require a valid candiate
    require(_candidateId > 0 && _candidateId <= candidatesCount);

    //Record that voter has voted
    voters[msg.sender] = true;

    // Update candidate vote count
    candidates[_candidateId].voteCount ++;

    //Trigger voted event
    votedEvent(_candidateId);
  }

}
//mapping(uint => Candidate) public candidates==> (Fetch(引き出す a candidate) Solidityのmappingはハッシュによるキーとバリューのイメージ。A mapping inSolidity is like an associative array or a hash, that associates key-value pairs. Read,writeできて、実行する度に手数料がかかるか確認。

//uint public candidatesCount ==> 候補者の人数をカウント。デフォルトはは0から。この変数を作ることにより、他の変数が効果的に活用できたり、登録された候補者の総数を把握できたりできる。

//function addCandidate(string _name) private ==> 資格のある人のみ候補者を増やす事ができるよう設計するため、privateで設計する。

//candidates [candidatesCount] = Candidate(candidatesCount, _name, 0); ==> struct Candidateのデフォルト値を設定。つまり追加された人のIDはcandidatesCountで付与され、名前は_name(ローカル変数。。。一時保存？)そして獲得票は0からスタート。

//require(!voters[msg.sender]); ==> msg.senderはまだVoders配列に入っていない事で、まだ投票したことがないことを確認。

//どうして_candidateId = Candidate {uint id}につながるのか ==> candidates[_candidateId]となっている。つまり、voteの引数はcandidatesの配列の中から候補者を探し出し、探し出した候補者の獲得表を+1する。

//bool ==> booleanつまり真偽の確認だと思う。
//_candidateId <= candidatesCount); _candidateIdはcandidatesCount より同じか小さくないといけないことだと思う。
