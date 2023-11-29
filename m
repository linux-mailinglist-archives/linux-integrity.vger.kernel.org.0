Return-Path: <linux-integrity+bounces-280-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0001D7FCC8A
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Nov 2023 03:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D79328315D
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Nov 2023 02:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9EC1FB3;
	Wed, 29 Nov 2023 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ddCZ72ER"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F08A10EB;
	Tue, 28 Nov 2023 18:07:36 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT1oZug013562;
	Wed, 29 Nov 2023 02:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=q69/ySyS1Q13h0fb7iRkfeR2Gyxb8mm8SutU+U1NBCo=;
 b=ddCZ72ERO9u5xLUNZ0KgUPvbDS1AItd6s9DmTU0oNUx7yV4s7xh61XT5GLT1xAo7r/7h
 tZedPmFWZZ6ksx3UtGvMfDrNxbMtQmA7Ca/vn2cIBRPsZJCM+D/p1e12FxkH539meNgA
 +tzWNPpqNLz6NviQb2vMZ8QQQwH4MOfWadhiDzNSLFzUzRrUFdBLBBceD2vqNIRmfbS1
 6ygELXxh97z2qtL0cUczYkgEe9obT5FJndukAf3slKr6QUSiGJnb3tu1N99cx4IIsWcf
 8g+K29rjjtvEBjCCVC9RUzO593lxWPcoqszilfq7XCyjNFiPc8qegcZ8XNPkXsjeiOc2 xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unts31v2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:07:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT1pSVM015527;
	Wed, 29 Nov 2023 02:07:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unts31v2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:07:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT2590B004934;
	Wed, 29 Nov 2023 02:07:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfk3yhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:07:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AT276NL25363010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 02:07:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B262258045;
	Wed, 29 Nov 2023 02:07:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0636B58050;
	Wed, 29 Nov 2023 02:07:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.89.136])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Nov 2023 02:07:04 +0000 (GMT)
Message-ID: <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
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
Date: Tue, 28 Nov 2023 21:07:04 -0500
In-Reply-To: <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
	 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
	 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
	 <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
	 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
	 <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
	 <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Oy_5AgL3qk6lrf4NBu9pEZ_-IEp22cBj
X-Proofpoint-ORIG-GUID: Y_lDUo6oEI5OG36TRnxNJxEgCg-F7XtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=986
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290014

On Tue, 2023-11-28 at 20:06 -0500, Paul Moore wrote:
> On Tue, Nov 28, 2023 at 7:09 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Mon, 2023-11-27 at 17:16 -0500, Paul Moore wrote:
> > > On Mon, Nov 27, 2023 at 12:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:
> 
> ...
> 
> > > If we are going to have a record count, I imagine it would also be
> > > helpful to maintain a securityfs file with the total size (in bytes)
> > > of the in-memory measurement log.  In fact, I suspect this will
> > > probably be more useful for those who wish to manage the size of the
> > > measurement log.
> >
> > A running number of bytes needed for carrying the measurement list
> > across kexec already exists.  This value would be affected when the
> > measurement list is trimmed.
> 
> There we go, it should be trivial to export that information via securityfs.
> 
> > > > Defining other IMA securityfs files like
> > > > how many times the measurement list has been trimmed might be
> > > > beneficial as well.
> > >
> > > I have no objection to that.  Would a total record count, i.e. a value
> > > that doesn't reset on a snapshot event, be more useful here?
> >
> > <securityfs>/ima/runtime_measurements_count already exports the total
> > number of measurement records.
> 
> I guess the question is would you want 'runtime_measurements_count' to
> reflect the current/trimmed log size or would you want it to reflect
> hthe measurements since the initial cold boot?  Presumably we would
> want to add another securityfs file to handle the case not covered by
> 'runtime_measurements_count'.

Right.  <securityfs>/ima/runtime_measurements_count is defined as the
total number of measurements since boot.  When the measurement list is
carried across kexec, it is the number of measurements since cold boot.

A new securityfs file should be defined for the current number of in
kernel memory records.  Unless the measurement list has been trimmed,
this should be the same as the runtime_measurements_count.

> 
> > > > Before defining a new critical-data record, we need to decide whether
> > > > it is really necessary or if it is redundant.  If we define a new
> > > > "critical-data" record, can it be defined such that it doesn't require
> > > > pausing extending the measurement list?  For example, a new simple
> > > > visual critical-data record could contain the number of records (e.g.
> > > > <securityfs>/ima/runtime_measurements_count) up to that point.
> > >
> > > What if the snapshot_aggregate was a hash of the measurement log
> > > starting with either the boot_aggregate or the latest
> > > snapshot_aggregate and ending on the record before the new
> > > snapshot_aggregate?  The performance impact at snapshot time should be
> > > minimal as the hash can be incrementally updated as new records are
> > > added to the measurement list.  While the hash wouldn't capture the
> > > TPM state, it would allow some crude verification when reassembling
> > > the log.  If one could bear the cost of a TPM signing operation, the
> > > log digest could be signed by the TPM.
> >
> > Other critical data is calculated, before calling
> > ima_measure_critical_data(), which adds the record to the measurement
> > list and extends the TPM PCR.
> >
> > Signing the hash shouldn't be an issue if it behaves like other
> > critical data.
> >
> > In addition to the hash, consider including other information in the
> > new critical data record (e.g. total number of measurement records, the
> > number of measurements included in the hash, the number of times the
> > measurement list was trimmed, etc).
> 
> It would be nice if you could provide an explicit list of what you
> would want hashed into a snapshot_aggregate record; the above is
> close, but it is still a little hand-wavy.  I'm just trying to reduce
> the back-n-forth :)

What is being defined here is the first IMA critical-data record, which
really requires some thought.  For ease of review, this new critical-
data record should be a separate patch set from trimming the
measurement list.

As I'm sure you're aware, SElinux defines two critical-data records.  
From security/selinux/ima.c:

        ima_measure_critical_data("selinux", "selinux-state",
                                  state_str, strlen(state_str), false,
                                  NULL, 0);

        ima_measure_critical_data("selinux", "selinux-policy-hash",
                                  policy, policy_len, true,
                                  NULL, 0);

-- 
thanks,

Mimi


