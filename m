Return-Path: <linux-integrity+bounces-227-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5EF7FA787
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 18:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E41C20A4E
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BBC36AE9;
	Mon, 27 Nov 2023 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IqB4jy0p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5307910F6;
	Mon, 27 Nov 2023 09:08:24 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARGIqEE024935;
	Mon, 27 Nov 2023 17:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SdXYOyFEsR3A/Q17azmhUsC6oJTh5KpTQfUstBbWeB4=;
 b=IqB4jy0pX2wfoN/MATdf3GugOKPmYfIgRIsUvrwj0Op6WvxHd5mRwdFsUWRy4nwcaSoM
 cKDGDpCAES1Lj4ty53WHucHH02X7yg3TROzk4TmkCjP+YTZLqujTUho+8xCAqsBjLt+G
 2BH440DLONrgA15UIFB3fnMC3tq9FuZhCuKqPY/nXVlhFASKDbEwPmSyvmAhVFwx3Sf7
 HIXh91tZeFhgTHeFE+7G+lPBnxyqtYx/2w5ehawZgN7tkrxFFgE2V+JSuQ0HuVDzHZUc
 brhKaYwKnPDAE+AXFZwIDwi1x3YUL0gpZf9M8qA1WHto7am0VYB53ZBbvL+F3bt0SJpb /A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxh09d27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:07:50 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARGftfI003246;
	Mon, 27 Nov 2023 17:07:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxh09d0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:07:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARGpRc1025565;
	Mon, 27 Nov 2023 17:07:47 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrk9xv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 17:07:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARH7keJ57082336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 17:07:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B6C758060;
	Mon, 27 Nov 2023 17:07:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D9F5803F;
	Mon, 27 Nov 2023 17:07:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.24.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Nov 2023 17:07:45 +0000 (GMT)
Message-ID: <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        Jarkko Sakkinen
 <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks
 <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        Sush Shringarputale
 <sushring@linux.microsoft.com>
Date: Mon, 27 Nov 2023 12:07:44 -0500
In-Reply-To: <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
	 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
	 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qzRtYvMLnm7cNTjPesp9QgY9v1vPugLu
X-Proofpoint-GUID: kpFDBoidQho8vTFczMJQe8Krbzu4x7I1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270119

On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:
> On Wed, Nov 22, 2023 at 8:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Tue, 2023-11-21 at 23:27 -0500, Paul Moore wrote:
> > > On Thu, Nov 16, 2023 at 5:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, Oct 31, 2023 at 3:15 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > ...
> > >
> > > > > Userspace can already export the IMA measurement list(s) via the
> > > > > securityfs {ascii,binary}_runtime_measurements file(s) and do whatever
> > > > > it wants with it.  All that is missing in the kernel is the ability to
> > > > > trim the measurement list, which doesn't seem all that complicated.
> > > >
> > > > From my perspective what has been presented is basically just trimming
> > > > the in-memory measurement log, the additional complexity (which really
> > > > doesn't look that bad IMO) is there to ensure robustness in the face
> > > > of an unreliable userspace (processes die, get killed, etc.) and to
> > > > establish a new, transitive root of trust in the newly trimmed
> > > > in-memory log.
> > > >
> > > > I suppose one could simplify things greatly by having a design where
> > > > userspace  captures the measurement log and then writes the number of
> > > > measurement records to trim from the start of the measurement log to a
> > > > sysfs file and the kernel acts on that.  You could do this with, or
> > > > without, the snapshot_aggregate entry concept; in fact that could be
> > > > something that was controlled by userspace, e.g. write the number of
> > > > lines and a flag to indicate if a snapshot_aggregate was desired to
> > > > the sysfs file.  I can't say I've thought it all the way through to
> > > > make sure there are no gotchas, but I'm guessing that is about as
> > > > simple as one can get.
> >
> > > > If there is something else you had in mind, Mimi, please share the
> > > > details.  This is a very real problem we are facing and we want to
> > > > work to get a solution upstream.
> > >
> > > Any thoughts on this Mimi?  We have a real interest in working with
> > > you to solve this problem upstream, but we need more detailed feedback
> > > than "too complicated".  If you don't like the solutions presented
> > > thus far, what type of solution would you like to see?
> >
> > Paul, the design copies the measurement list to a temporary "snapshot"
> > file, before trimming the measurement list, which according to the
> > design document locks the existing measurement list.  And further
> > pauses extending the measurement list to calculate the
> > "snapshot_aggregate".
> 
> I believe the intent is to only pause the measurements while the
> snapshot_aggregate is generated, not for the duration of the entire
> snapshot process.  The purpose of the snapshot_aggregate is to
> establish a new root of trust, similar to the boot_aggregate, to help
> improve attestation performance.
> 
> > Userspace can export the measurement list already, so why this
> > complicated design?
> 
> The current code has no provision for trimming the measurement log,
> that's the primary reason.
> 
> > As I mentioned previously and repeated yesterday, the
> > "snapshot_aggregate" is a new type of critical data and should be
> > upstreamed independently of this patch set that trims the measurement
> > list.  Trimming the measurement list could be based, as you suggested
> > on the number of records to remove, or it could be up to the next/last
> > "snapshot_aggregate" record.
> 
> Okay, we are starting to get closer, but I'm still missing the part
> where you say "if you do X, Y, and Z, I'll accept and merge the
> solution."  Can you be more explicit about what approach(es) you would
> be willing to accept upstream?

Included with what is wanted/needed is an explanation as to my concerns
with the existing proposal.

First we need to differentiate between kernel and uhserspace
requirements.  (The "snapshotting" design proposal intermixes them.)

From the kernel persective, the Log Snapshotting Design proposal "B.1
Goals" is very nice, but once the measurement list can be trimmed it is
really irrelevant.  Userspace can do whatever it wants with the
measurement list records.  So instead of paying lip service to what
should be done, just call it as it is - trimming the measurement list.

-----------------------------------------------------------------------
| B.1 Goals                                                           |
-----------------------------------------------------------------------
To address the issues described in the section above, we propose
enhancements to the IMA subsystem to achieve the following goals:

  a. Reduce memory pressure on the Kernel caused by larger in-memory
     IMA logs.

  b. Preserve the system's ability to get remotely attested using the
     IMA log, even after implementing the enhancements to reduce memory
     pressure caused by the IMA log. IMA's Integrity guarantees should
     be maintained.

  c. Provide mechanisms from Kernel side to the remote attestation
     service to make service-side processing more efficient.

From the kernel perspective there needs to be a method of trimming N
number of records from the head of the measurement list.  In addition
to the existing securityfs "runtime measurement list",  defining a new
securityfs file containing the current count of in memory measurement
records would be beneficial.  Defining other IMA securityfs files like
how many times the measurement list has been trimmed might be
beneficial as well.  Of course properly document the integrity
implications and repercussions of the new Kconfig that allows trimming
the measurement list.

Defining a simple "trim" marker measurement record would be a visual
indication that the measurement list has been trimmed.  I might even
have compared it to the "boot_aggregate".  However, the proposed marker
based on TPM PCRs requires pausing extending the measurement list.  
Although the TCG TPM spec allows reading multiple PCRs, it may fail due
to the output buffer size.  To avoid TPM read multiple PCRs failure,
reading one TPM PCR value at a time is safer.  The more TPM banks and
PCRs needed the longer it will take.  Remember this critical-data
record won't be limited to just software TPMs, but could be used with
physical ones as well.  For a physical TPM, this could be on the orderof 240 ms per TPM bank (24 PCRs). 

Before defining a new critical-data record, we need to decide whether
it is really necessary or if it is redundant.  If we define a new
"critical-data" record, can it be defined such that it doesn't require
pausing extending the measurement list?  For example, a new simple
visual critical-data record could contain the number of records (e.g.
<securityfs>/ima/runtime_measurements_count) up to that point.

The new critical-data record and trimming the measurement list should
be disjoint features.  If the first record after trimming the
measurement list should be the critical-data record, then trim the
measurement list up to that point.

From a userspace perspective, trimming the measurement list is a major
change and will break existing attestation requests, unless the change
is transparent.  Removing "snapshots"/"shards" will of course break
attestation requests.  Refer to Stefan's suggestions: 
https://lore.kernel.org/linux-integrity/1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com/

-- 
thanks,

Mimi


