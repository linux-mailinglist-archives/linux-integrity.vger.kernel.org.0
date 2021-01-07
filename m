Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07DA2EE988
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Jan 2021 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbhAGXBX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 18:01:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728534AbhAGXBX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 18:01:23 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 107MX8RK055030;
        Thu, 7 Jan 2021 18:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=djGqFdX6Yp2+RevvDkAzOQopt4ApoLVp3qyOwQh1etw=;
 b=GniLimlGgF7n0ctNIWXBLhzxpD0mSq4ZO91GKDkJrKkiV1XZmuNVF7W/RI7isIVKN37O
 OoXDfde48tQ6IBl3d05XKizubNtMokSMaPU5O+TVEfNVpBHSePpImvJ27KDU5719u/mU
 CFMbY5yCxXQ7be5tAY8d1wtt2kd1rcQCOMcwOupEUxK29jIjHx/UMwp93ZHPkcuYLTPN
 pL2lCakixUjCoJQIdQQL570bmjjxiLttg2ivfusQ7lzY9IihDfJJvQh50M8dS4H0nBUL
 oVapomwZZCzOH+i3+I6M/TJUnv/oa7UrnqjSCvu7l8tVrVCGZHqjOra6gkAgDWEfesVz hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35xb5ngj0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 18:00:40 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 107MxU9X033442;
        Thu, 7 Jan 2021 18:00:40 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35xb5nghy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 18:00:39 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 107Mn1Bv011121;
        Thu, 7 Jan 2021 23:00:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 35tgf8dbms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 23:00:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 107N0XE928639660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jan 2021 23:00:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4A78A406D;
        Thu,  7 Jan 2021 23:00:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6C65A4062;
        Thu,  7 Jan 2021 23:00:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.227])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jan 2021 23:00:31 +0000 (GMT)
Message-ID: <6da004ef930540e0ff808f6a2e474d3b3c15f60f.camel@linux.ibm.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 07 Jan 2021 18:00:30 -0500
In-Reply-To: <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
         <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
         <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
         <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
         <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
         <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
         <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_11:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-07 at 13:48 -0800, James Bottomley wrote:
> On Thu, 2021-01-07 at 15:51 -0500, Mimi Zohar wrote:
> > On Thu, 2021-01-07 at 12:37 -0800, James Bottomley wrote:
> > > On Thu, 2021-01-07 at 15:02 -0500, Mimi Zohar wrote:
> > > > On Thu, 2021-01-07 at 08:42 -0800, James Bottomley wrote:
> [...]
> > > > > What about having a log entry that's the current PCR
> > > > > value?  Then stretches of the log starting with these entries
> > > > > would be independently verifiable provided you had a way of
> > > > > trusting the PCR value.  It might be possible to get the TPM to
> > > > > add a signed quote as an optional part of the log entry (of
> > > > > course this brings other problems like which key do you use for
> > > > > the signing and how does it get verified) which would provide
> > > > > the trust and would definitively allow you to archive log
> > > > > segments and still make the rest of the log useful.
> > > > 
> > > > The current PCR values are aggregated and stored in the
> > > > boot_aggregate record.  As part of the new boot_aggregate record
> > > > format, the individual PCR values could be included.
> > > 
> > > I don't think we care about the boot aggregate ... it's just the
> > > initial log entry that ties the boot state to the initial runtime
> > > state.  All we need for the proposed entry is the current value of
> > > the IMA PCR so provided you trust that value it becomes a base on
> > > which the following measurements can build and be trusted.
> > 
> > The IMA measurement list may contain multiple PCRs, not just the
> > default IMA PCR.   Each kexec results in an additional boot_aggregate
> > record, but an equivalent record for after truncating the measurement
> > list might help.
> 
> Right, this would specifically be only of the IMA PCR so you can use it
> as a base to begin the hash of the following log segment.  The log can
> still contain other boot aggregate entries, but the assumption is that
> boot aggregate entries in the prior log have already been evaluated.

IMA may be configured on a per rule basis to measure files into
different PCRs.  Between the previous boot aggregate record and
truncating the measurement list, other PCRs may have been extended.

> 
> > > > But this doesn't address where the offloaded measurement list
> > > > will be stored, how long the list will be retained, nor who
> > > > guarantees the integrity of the offloaded list.  In addition,
> > > > different form factors will have different requirements.
> > > 
> > > I'm not sure you need any store at all.  The basic idea is that the
> > > log is divided into individually verifiable segments.  For auditing
> > > purposes you could keep all segments, so you have the entire log,
> > > but if you've acted on the prior log entries and you don't have an
> > > audit reason to keep them, you could erase that segment of the log
> > > because you've placed all your trust in the prior log segments into
> > > the PCR entry that forms the base of your current segment.
> > > 
> > > Essentially the question devolves to what mechanisms can give you
> > > this trust in the base PCR log entry.
> > 
> > 
> > Not retaining the entire measurement list would limit it's verification
> > to a single server/system.
> 
> Well, it would limit its verification to just that log segment, yes.

Verifying only the current log segment only makes sense, if the
previous log segments were previously verified.

> 
> I'm thinking in the cloud there are a couple of potential consumers:  
> 
>    1. The cloud monitor, which acts on the verified log, such as killing a
>       node for trying to execute an unverified binary or emailing the
>       guest owner.  This type of consumer doesn't need the historical log,
>       they just need to verify the entries they haven't already seen and
>       act on them according to whatever policy they're given.
>    2. The second type of cloud consumer is the audit case where the
>       aggregate hash is used to assure some auditor, some time after the
>       actual events, that the entire runtime of the VM was properly
>       monitored and the auditor wants to see the log  or a segment of it
>       to prove the hash.
> 
> Case 1 doesn't need historical storage, case 2 definitely does.  I
> think we should support both use cases particularly in the long running
> scenario where we need to recover memory.  Having verifiable log
> segments seems to satisfy both cases, but what you do with the segments
> would vary.

As Ken previously pointed out, the attestation server itself can
request only the new measurements.

Mimi

