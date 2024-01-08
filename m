Return-Path: <linux-integrity+bounces-686-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3911826D26
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jan 2024 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299211F224D9
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jan 2024 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF614AAE;
	Mon,  8 Jan 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ewk+LiKR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1225116;
	Mon,  8 Jan 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408AdrtL024094;
	Mon, 8 Jan 2024 11:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PWMiGE+EAHOh+QuiJv8ydNKljFRfdXalJMkKSiG6J6M=;
 b=Ewk+LiKRtejfwMDcH1dvqotrfxKlMuv+Sg9CaUVOzRLRwzTuGnWKm6ucDIhVl7sX2tTv
 k3U82SNydWhJAQnxWntT6AqGgveHy5vlx3O9poh5T0bHc/54UigwyzKqjjQeSq41uffC
 T3nOCkSlJOebvu3mWA2kWP82dcIrdpiI/UgqMMrmj4V8u3J8eNi4344jenoKuNfVUwMl
 UO2H4GDFLe/VJf05hnRmEcryaRa7mpUHHP+1zn0Ko/puiw6S9zOVsU7QzOz1SzJTmWRi
 hIQ/br+P+D5y3B8n+U1f1y8ZWhqJHm+jZlVayfBKXrFnXs+SDCfix4ymYZsMDpUumxG3 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf6akyass-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 11:48:24 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408Bgs9c025340;
	Mon, 8 Jan 2024 11:48:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf6akyasb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 11:48:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4088gnjm022808;
	Mon, 8 Jan 2024 11:48:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjy7tbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 11:48:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408BmL0B39322166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 11:48:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2D5258056;
	Mon,  8 Jan 2024 11:48:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4305803F;
	Mon,  8 Jan 2024 11:48:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.78.221])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 11:48:20 +0000 (GMT)
Message-ID: <b915f194c9024233d9f6f6ccbf417c26600ee261.camel@linux.ibm.com>
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
Date: Mon, 08 Jan 2024 06:48:20 -0500
In-Reply-To: <CAHC9VhRYLLtdOD1GTtigTrgsALdBqUikiNhdBNSaLYxD1iN8bw@mail.gmail.com>
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
	 <d9975a7949ca49f404adc981e942f42b6f19d022.camel@linux.ibm.com>
	 <CAHC9VhRd5Qi_NZJMOfHC6jTr_dn0mNFGhy18ff2YgtjQo+38dQ@mail.gmail.com>
	 <5faa2b81b550d44f0a02917f11c4838d11cbda00.camel@linux.ibm.com>
	 <CAHC9VhRYLLtdOD1GTtigTrgsALdBqUikiNhdBNSaLYxD1iN8bw@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: HtZ9x97zWyqS3cQqbPZB5mAODGIDKmdc
X-Proofpoint-GUID: usKHAPvhjvYxsA9_ocvpV0R_NQbsR9MA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_03,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=950 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080101

On Sun, 2024-01-07 at 21:58 -0500, Paul Moore wrote:
> On Sun, Jan 7, 2024 at 7:59 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Sat, 2024-01-06 at 18:27 -0500, Paul Moore wrote:
> > > On Tue, Nov 28, 2023 at 9:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Tue, 2023-11-28 at 20:06 -0500, Paul Moore wrote:
> > > > > On Tue, Nov 28, 2023 at 7:09 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > On Mon, 2023-11-27 at 17:16 -0500, Paul Moore wrote:
> > > > > > > On Mon, Nov 27, 2023 at 12:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > > > On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:
> > >
> > > ...
> > >
> > > > > > > > Before defining a new critical-data record, we need to decide whether
> > > > > > > > it is really necessary or if it is redundant.  If we define a new
> > > > > > > > "critical-data" record, can it be defined such that it doesn't require
> > > > > > > > pausing extending the measurement list?  For example, a new simple
> > > > > > > > visual critical-data record could contain the number of records (e.g.
> > > > > > > > <securityfs>/ima/runtime_measurements_count) up to that point.
> > > > > > >
> > > > > > > What if the snapshot_aggregate was a hash of the measurement log
> > > > > > > starting with either the boot_aggregate or the latest
> > > > > > > snapshot_aggregate and ending on the record before the new
> > > > > > > snapshot_aggregate?  The performance impact at snapshot time should be
> > > > > > > minimal as the hash can be incrementally updated as new records are
> > > > > > > added to the measurement list.  While the hash wouldn't capture the
> > > > > > > TPM state, it would allow some crude verification when reassembling
> > > > > > > the log.  If one could bear the cost of a TPM signing operation, the
> > > > > > > log digest could be signed by the TPM.
> > > > > >
> > > > > > Other critical data is calculated, before calling
> > > > > > ima_measure_critical_data(), which adds the record to the measurement
> > > > > > list and extends the TPM PCR.
> > > > > >
> > > > > > Signing the hash shouldn't be an issue if it behaves like other
> > > > > > critical data.
> > > > > >
> > > > > > In addition to the hash, consider including other information in the
> > > > > > new critical data record (e.g. total number of measurement records, the
> > > > > > number of measurements included in the hash, the number of times the
> > > > > > measurement list was trimmed, etc).
> > > > >
> > > > > It would be nice if you could provide an explicit list of what you
> > > > > would want hashed into a snapshot_aggregate record; the above is
> > > > > close, but it is still a little hand-wavy.  I'm just trying to reduce
> > > > > the back-n-forth :)
> > > >
> > > > What is being defined here is the first IMA critical-data record, which
> > > > really requires some thought.
> > >
> > > My thinking has always been that taking a hash of the current
> > > measurement log up to the snapshot point would be a nice
> > > snapshot_aggregate measurement, but I'm not heavily invested in that.
> > > To me it is more important that we find something we can all agree on,
> > > perhaps reluctantly, so we can move forward with a solution.
> > >
> > > > For ease of review, this new critical-
> > > > data record should be a separate patch set from trimming the
> > > > measurement list.
> > >
> > > I see the two as linked, but if you prefer them as separate then so be
> > > it.  Once again, the important part is to move forward with a
> > > solution, I'm not overly bothered if it arrives in multiple pieces
> > > instead of one.
> >
> > Trimming the IMA measurement list could be used in conjunction with the new IMA
> > critical data record or independently.  Both options should be supported.
> >
> > 1. trim N number of records from the head of the in kernel IMA measurement list
> > 2. intermittently include the new IMA critical data record based on some trigger
> > 3. trim the measurement list up to the (first/last/Nth) IMA critical data record
> >
> > Since the two features could be used independently of each other, there is no
> > reason to upstream them as a single patch set.  It just makes it harder to
> > review.
> 
> I don't see much point in recording a snapshot aggregate if you aren't
> doing a snapshot, but it's not harmful in any way, so sure, go for it.
> Like I said earlier, as long as the functionality is there, I don't
> think anyone cares too much how it gets into the kernel (although
> Tushar and Sush should comment from the perspective).

Paul, there are two features: 
- trimming the measurement list
- defining and including an IMA critical data record

The original design doc combined these two features making them an "atomic"
operation and referred to it as a snapshot.  At the time the term "snapshot" was
an appropriate term for the IMA critical record.  Now not so much.

These are two separate, independent features.  Trimming the measurement list
should not be dependent on the IMA critical data record.  The IMA critical data
record should not be dependent on trimming the measurement list.  Trimming the
measurement list up to the (first/last/Nth) critical data record should be
optional.

> 
> > > > As I'm sure you're aware, SElinux defines two critical-data records.
> > > > From security/selinux/ima.c:
> > > >
> > > >         ima_measure_critical_data("selinux", "selinux-state",
> > > >                                   state_str, strlen(state_str), false,
> > > >                                   NULL, 0);
> > > >
> > > >         ima_measure_critical_data("selinux", "selinux-policy-hash",
> > > >                                   policy, policy_len, true,
> > > >                                   NULL, 0);
> > >
> > > Yep, but there is far more to this than SELinux.
> >
> > Only if you conflate the two features.
> 
> If that is a clever retort, you'll need to elaborate a bit as it
> doesn't make much sense to me.  The IMA measurement log snapshot is
> independent from SELinux; the only connection is that yes, IMA does
> measure SELinux "things" but that is no different from any other
> system attribute that is measured by IMA.

The IMA critical data record should not be that different or more difficult,
than the SELinux critical data record.  Only if you conflate the two features
being discussed - trimming the IMA measurement list and the IMA critical data
record - does it become "far more".

--  
Mimi  




