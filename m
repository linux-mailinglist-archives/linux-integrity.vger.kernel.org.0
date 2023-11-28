Return-Path: <linux-integrity+bounces-258-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769AB7FB9E9
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D37F2821E8
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33F24F883;
	Tue, 28 Nov 2023 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SP6VOhHB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB92182;
	Tue, 28 Nov 2023 04:09:47 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASBhDAd024208;
	Tue, 28 Nov 2023 12:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6kcjejUaVubGnruZDMYniG++V65U9fwBxMeJgLz5iqE=;
 b=SP6VOhHBCjawqVoW5PYBMM1HQNmTH86C0kZqDWJVgHiNwk4cvcMGAvWPkjfztA4Dx1L5
 gn+qayhBLB/faw4ZzKt81pKwvbkvtwPNe1z/KYP0RCDpjBuPSYKy8V/QFa6xd340pjth
 qYpmolzmLPFo/Lyeh45X8eGOOXCwMHKd+a0OYKF6CUbgmtoFGxcizkn9Df3gddLnuDvl
 YKK2eUnFo4M+YYEO2kMlXnYseSjPOkOjdgQ+gAkd20VJ0lrBXLsRJkbIOk1A6otYLT1z
 3Yj+VVbCpJyLk73YWgPSiRRt3u5cnURc1ROfe9ejVX1oHExnEKqALwKEdpDWu/kTtriF Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unfk00qch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:09:26 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASBi0NO027332;
	Tue, 28 Nov 2023 12:09:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unfk00qc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:09:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAaIEg004998;
	Tue, 28 Nov 2023 12:09:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjy3yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:09:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASC9OhR983802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 12:09:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61B9F58059;
	Tue, 28 Nov 2023 12:09:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B34DC58058;
	Tue, 28 Nov 2023 12:09:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.23.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 12:09:22 +0000 (GMT)
Message-ID: <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
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
Date: Tue, 28 Nov 2023 07:09:22 -0500
In-Reply-To: <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
	 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
	 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
	 <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
	 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XuEYEisphN9tRJreT0pzilHbdjFLRHl5
X-Proofpoint-GUID: K79ozYhrCZnE6n-PVIP1Gn6EMNeKutJc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_12,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280096

On Mon, 2023-11-27 at 17:16 -0500, Paul Moore wrote:
> On Mon, Nov 27, 2023 at 12:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:
> 
> ...
> 
> > > Okay, we are starting to get closer, but I'm still missing the part
> > > where you say "if you do X, Y, and Z, I'll accept and merge the
> > > solution."  Can you be more explicit about what approach(es) you would
> > > be willing to accept upstream?
> >
> > Included with what is wanted/needed is an explanation as to my concerns
> > with the existing proposal.
> >
> > First we need to differentiate between kernel and uhserspace
> > requirements.  (The "snapshotting" design proposal intermixes them.)
> >
> > From the kernel persective, the Log Snapshotting Design proposal "B.1
> > Goals" is very nice, but once the measurement list can be trimmed it is
> > really irrelevant.  Userspace can do whatever it wants with the
> > measurement list records.  So instead of paying lip service to what
> > should be done, just call it as it is - trimming the measurement list.
> 
> Fair enough.  I personally think it is nice to have a brief discussion
> of how userspace might use a kernel feature, but if you prefer to drop
> that part of the design doc I doubt anyone will object very strongly.
> 
> > From the kernel perspective there needs to be a method of trimming N
> > number of records from the head of the measurement list.  In addition
> > to the existing securityfs "runtime measurement list",  defining a new
> > securityfs file containing the current count of in memory measurement
> > records would be beneficial.
> 
> I imagine that should be trivial to implement and I can't imagine
> there being any objection to that.
> 
> If we are going to have a record count, I imagine it would also be
> helpful to maintain a securityfs file with the total size (in bytes)
> of the in-memory measurement log.  In fact, I suspect this will
> probably be more useful for those who wish to manage the size of the
> measurement log.

A running number of bytes needed for carrying the measurement list
across kexec already exists.  This value would be affected when the
measurement list is trimmed.

...

> 
> > Defining other IMA securityfs files like
> > how many times the measurement list has been trimmed might be
> > beneficial as well.
> 
> I have no objection to that.  Would a total record count, i.e. a value
> that doesn't reset on a snapshot event, be more useful here?

<securityfs>/ima/runtime_measurements_count already exports the total
number of measurement records.

> 
> > Of course properly document the integrity
> > implications and repercussions of the new Kconfig that allows trimming
> > the measurement list.
> 
> Of course.
> 
> > Defining a simple "trim" marker measurement record would be a visual
> > indication that the measurement list has been trimmed.  I might even
> > have compared it to the "boot_aggregate".  However, the proposed marker
> > based on TPM PCRs requires pausing extending the measurement list.
> 
> ...
> 
> > Before defining a new critical-data record, we need to decide whether
> > it is really necessary or if it is redundant.  If we define a new
> > "critical-data" record, can it be defined such that it doesn't require
> > pausing extending the measurement list?  For example, a new simple
> > visual critical-data record could contain the number of records (e.g.
> > <securityfs>/ima/runtime_measurements_count) up to that point.
> 
> What if the snapshot_aggregate was a hash of the measurement log
> starting with either the boot_aggregate or the latest
> snapshot_aggregate and ending on the record before the new
> snapshot_aggregate?  The performance impact at snapshot time should be
> minimal as the hash can be incrementally updated as new records are
> added to the measurement list.  While the hash wouldn't capture the
> TPM state, it would allow some crude verification when reassembling
> the log.  If one could bear the cost of a TPM signing operation, the
> log digest could be signed by the TPM.

Other critical data is calculated, before calling
ima_measure_critical_data(), which adds the record to the measurement
list and extends the TPM PCR.

Signing the hash shouldn't be an issue if it behaves like other
critical data.

In addition to the hash, consider including other information in the
new critical data record (e.g. total number of measurement records, the
number of measurements included in the hash, the number of times the
measurement list was trimmed, etc). 

> 
> > The new critical-data record and trimming the measurement list should
> > be disjoint features.  If the first record after trimming the
> > measurement list should be the critical-data record, then trim the
> > measurement list up to that point.
> 
> I disagree about the snapshot_aggregate record being disjoint from the
> measurement log, but I suspect Tushar and Sush are willing to forgo
> the snapshot_aggregate if that is a blocker from your perspective.

> Once again, the main goal is the ability to manage the size of the
> measurement log; while having a snapshot_aggregate that can be used to
> establish a root of trust similar to the boot_aggregate is nice, it is
> not a MUST have.

The problem isn't the "snapshot_aggregate" critical data record per-se, 
but pausing adding measurements to the IMA measurement list and
extending the PCR to calculate it.

(Perhaps including other information, like the number of IMA
measurements before or after reading each TPM PCR read, would eliminate
the need for pausing the measurement list.)

> > From a userspace perspective, trimming the measurement list is a major
> change and will break existing attestation requests, unless the change
> is transparent.  Removing "snapshots"/"shards" will of course break
> attestation requests.  Refer to Stefan's suggestions:
>https://lore.kernel.org/linux-integrity/1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com/ > 
> You will note that Sush and I replied to Stefan two weeks ago.

Yes, I saw.  This might be a good place, as you suggested, "to have a
brief discussion
of how userspace might use a kernel feature".  Perhaps rename this
thread to differentiate it from the kernel design.

-- 
thanks,

Mimi


