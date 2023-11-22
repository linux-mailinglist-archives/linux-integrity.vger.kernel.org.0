Return-Path: <linux-integrity+bounces-189-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE777F478D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B9CB20C54
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED54C63C;
	Wed, 22 Nov 2023 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TL3Ys8Lo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EA410C;
	Wed, 22 Nov 2023 05:18:39 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMD9juj030220;
	Wed, 22 Nov 2023 13:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IrmURnvMILkV8BBA/aqBOUU/iNdfg2KlHJ+BlsU/afk=;
 b=TL3Ys8Loeb9W4MhwrEPIj63ZA5Q9Qj81qaodH+QWEUdJJZna9/s+IUSKFmPo9uLh/lhc
 IgASGMUGhLyDPhOa/f+78K9q4UMGhStH1SeC3TTbPU71aF14HUTDj8qFUt9WtQTshrwg
 uuKwHQOBKiby3og+5sPJZt+I98vS3ylf0Z3VEsHA/6XvyvZ2axWa2os4e5tHuG1+p7eS
 GwCPgUDTjCz2RDvRP7EqsGXHSRVM3rtHJQBlEwOM/lSMb18WAGUYCMr6XGkh6g37v3po
 qXNcMpGY1z4DmCvpSgz3Dn2jMc/d1Ywn7I1rHlJRWB6enDQT8X6dkTgSpPPeEFZj1mLO cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhj9jr9be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 13:18:20 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AMDA5EQ030739;
	Wed, 22 Nov 2023 13:18:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhj9jr9ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 13:18:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMAJnVt001719;
	Wed, 22 Nov 2023 13:18:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kyup8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 13:18:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMDIHtR17826350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 13:18:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AF195805E;
	Wed, 22 Nov 2023 13:18:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78E358059;
	Wed, 22 Nov 2023 13:18:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.52.147])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 13:18:15 +0000 (GMT)
Message-ID: <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
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
Date: Wed, 22 Nov 2023 08:18:15 -0500
In-Reply-To: <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: 0czCmu0bpYYjxWr0WuxlMnhsqfRJCMiO
X-Proofpoint-GUID: RLicAhrwV9xSmJTXUajhN8W0XzacRsR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220094

On Tue, 2023-11-21 at 23:27 -0500, Paul Moore wrote:
> On Thu, Nov 16, 2023 at 5:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Oct 31, 2023 at 3:15 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> ...
> 
> > > Userspace can already export the IMA measurement list(s) via the
> > > securityfs {ascii,binary}_runtime_measurements file(s) and do whatever
> > > it wants with it.  All that is missing in the kernel is the ability to
> > > trim the measurement list, which doesn't seem all that complicated.
> >
> > From my perspective what has been presented is basically just trimming
> > the in-memory measurement log, the additional complexity (which really
> > doesn't look that bad IMO) is there to ensure robustness in the face
> > of an unreliable userspace (processes die, get killed, etc.) and to
> > establish a new, transitive root of trust in the newly trimmed
> > in-memory log.
> >
> > I suppose one could simplify things greatly by having a design where
> > userspace  captures the measurement log and then writes the number of
> > measurement records to trim from the start of the measurement log to a
> > sysfs file and the kernel acts on that.  You could do this with, or
> > without, the snapshot_aggregate entry concept; in fact that could be
> > something that was controlled by userspace, e.g. write the number of
> > lines and a flag to indicate if a snapshot_aggregate was desired to
> > the sysfs file.  I can't say I've thought it all the way through to
> > make sure there are no gotchas, but I'm guessing that is about as
> > simple as one can get.

> > If there is something else you had in mind, Mimi, please share the
> > details.  This is a very real problem we are facing and we want to
> > work to get a solution upstream.
> 
> Any thoughts on this Mimi?  We have a real interest in working with
> you to solve this problem upstream, but we need more detailed feedback
> than "too complicated".  If you don't like the solutions presented
> thus far, what type of solution would you like to see?

Paul, the design copies the measurement list to a temporary "snapshot"
file, before trimming the measurement list, which according to the
design document locks the existing measurement list.  And further
pauses extending the measurement list to calculate the
"snapshot_aggregate".

Userspace can export the measurement list already, so why this
complicated design?

As I mentioned previously and repeated yesterday, the
"snapshot_aggregate" is a new type of critical data and should be
upstreamed independently of this patch set that trims the measurement
list.  Trimming the measurement list could be based, as you suggested
on the number of records to remove, or it could be up to the next/last
"snapshot_aggregate" record.

-- 
thanks,

Mimi


