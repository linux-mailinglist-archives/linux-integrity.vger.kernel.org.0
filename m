Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493312EE734
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 21:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbhAGUv4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 15:51:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbhAGUv4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 15:51:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 107K2r7T107055;
        Thu, 7 Jan 2021 15:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WCq0yT610onfOtsq132GNI0xtYNiI5cXj5LnFbz9z2U=;
 b=Wvx8cII7fSFmnlBHo4G8Di193fizjulqy178h+1i5NJ1NahxU56+XMpAbzD/GP3CDbmh
 HIqa2yzUHUEbMGRfnDm4pyRRBE8hryrGxKqwyfAchZFx78nVQQKTXKao3wJto/4kCjj2
 eS6PKH9FK+dYI3sdtS4m7kQPlBqBxgX1vJpASXcngpwG4V3Gy3T/M0GROe3Wv0jbPONa
 emDgS9l8cnjxh0pB77BGaNYSI7rYxP7UAj8V13uCF74iFFA2FVEINtbBwcZhQIwX99Si
 a5cRXxgnPQ1r7yDXclM047MET0d8D3Oh14Wp9KWjPKdkJHRYswPWovOvrGcvYy4WNELt 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35x8x594xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 15:51:14 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 107Km8L7081054;
        Thu, 7 Jan 2021 15:51:14 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35x8x594x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 15:51:14 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 107KgHS9005301;
        Thu, 7 Jan 2021 20:51:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 35tgf8aqsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 20:51:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 107Kp9qO42729804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jan 2021 20:51:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ACD54C052;
        Thu,  7 Jan 2021 20:51:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A243E4C046;
        Thu,  7 Jan 2021 20:51:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.227])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jan 2021 20:51:07 +0000 (GMT)
Message-ID: <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 07 Jan 2021 15:51:06 -0500
In-Reply-To: <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
         <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
         <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
         <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
         <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_08:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-07 at 12:37 -0800, James Bottomley wrote:
> On Thu, 2021-01-07 at 15:02 -0500, Mimi Zohar wrote:
> > On Thu, 2021-01-07 at 08:42 -0800, James Bottomley wrote:
> > > On Thu, 2021-01-07 at 10:06 -0500, Mimi Zohar wrote:
> > > > [Cc: Amir Goldstein]
> > > > 
> > > > On Tue, 2021-01-05 at 11:57 -0800, Raphael Gianotti wrote:
> > > > > IMA measures files and buffer data and some systems may end up
> > > > > generating lots of entries in the IMA measurement list. This
> > > > > list is kept in kernel memoryc and as it grows in size it could
> > > > > end up taking too many resources, causing the system to run out
> > > > > of available memory. During kexec, the IMA measurement list can
> > > > > be carried over in memory, but it's possible for the list to
> > > > > become too large for that to happen.
> > > > > 
> > > > > The Kconfig introduced in this series enables admins to
> > > > > configure a maximum number of entries and a file to export the
> > > > > IMA measurement list to whenever the set limit is reached.
> > > > > 
> > > > > The list is written out in append mode, so the system will keep
> > > > > writing new entries as long as it stays running or runs out of
> > > > > space. Whenever the export file is set, it's truncated. If
> > > > > writing to the export list fails, a flag is set to prevent
> > > > > further exports, as the file is likely in a bad state. Setting
> > > > > a new export file resets this flag, allowing exports to resume
> > > > > and giving admins a way to recover from this state if
> > > > > necessary.
> > > > > 
> > > > > In the case of kexec, if the list is too large too be carried
> > > > > over in memory and an export file is configured, the list will
> > > > > be exported, preventing the measurements from being lost during
> > > > > kexec.
> > > > > 
> > > > > This code is based off of a previous RFC sent by Janne
> > > > > Karhunen[1], and is intended to pick up where that was left
> > > > > off.
> > > > > 
> > > > > In a thread with Janne Karhunen[2], it was mentioned that
> > > > > another approach, using mm had been considered. Upon some
> > > > > investigation the approach used in this RFC still seemed
> > > > > adequate for solving this problem.
> > > > > 
> > > > > [1] 
> > > > > https://patchwork.kernel.org/project/linux-integrity/patch/201912
> > > > > 20074929.8191-1-janne.karhunen@gmail.com/
> > > > > [2] 
> > > > > https://lore.kernel.org/linux-integrity/CAE=NcrbdS-3gVvnnEwdNSOLO
> > > > > vTenLjyppDz2aJACGRgBYSh=Gw@mail.gmail.com/
> > > > > 
> > > > > Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>
> > > > 
> > > > My original concerns of truncating the IMA measurement list have
> > > > not been addressed.  Once the IMA measurement list has been
> > > > truncated, quoting and then verifying any of the PCRs contained
> > > > in the measurement list will fail, unless the measurements have
> > > > been preserved and are readily accessible.
> > > > 
> > > > Amir's suggestion addresses kernel memory constraints without
> > > > truncating the IMA measurement list.
> > > 
> > > What about having a log entry that's the current PCR value?  Then
> > > stretches of the log starting with these entries would be
> > > independently verifiable provided you had a way of trusting the PCR
> > > value.  It might be possible to get the TPM to add a signed quote
> > > as an optional part of the log entry (of course this brings other
> > > problems like which key do you use for the signing and how does it
> > > get verified) which would provide the trust and would definitively
> > > allow you to archive log segments and still make the rest of the
> > > log useful.
> > 
> > The current PCR values are aggregated and stored in the
> > boot_aggregate record.  As part of the new boot_aggregate record
> > format, the individual PCR values could be included.
> 
> I don't think we care about the boot aggregate ... it's just the
> initial log entry that ties the boot state to the initial runtime
> state.  All we need for the proposed entry is the current value of the
> IMA PCR so provided you trust that value it becomes a base on which the
> following measurements can build and be trusted.

The IMA measurement list may contain multiple PCRs, not just the
default IMA PCR.   Each kexec results in an additional boot_aggregate
record, but an equivalent record for after truncating the measurement
list might help.
> 
> > But this doesn't address where the offloaded measurement list will be
> > stored, how long the list will be retained, nor who guarantees the
> > integrity of the offloaded list.  In addition, different form factors
> > will have different requirements.
> 
> I'm not sure you need any store at all.  The basic idea is that the log
> is divided into individually verifiable segments.  For auditing
> purposes you could keep all segments, so you have the entire log, but
> if you've acted on the prior log entries and you don't have an audit
> reason to keep them, you could erase that segment of the log because
> you've placed all your trust in the prior log segments into the PCR
> entry that forms the base of your current segment.
> 
> Essentially the question devolves to what mechanisms can give you this
> trust in the base PCR log entry.

Not retaining the entire measurement list would limit it's verification
to a single server/system.

Mimi

