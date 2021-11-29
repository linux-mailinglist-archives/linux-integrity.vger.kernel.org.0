Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7CD4618F2
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378551AbhK2Ofg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 09:35:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378931AbhK2Odd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 09:33:33 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATENT8W024172;
        Mon, 29 Nov 2021 14:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tSGHmS/RKX0Rx86SdmeCaFjCXS2oDYNxqtu714BHocg=;
 b=GptmoWDijskXe+fb3vF+8KLdmKdmCivt1OVRPbkNfUC7QyJt2J5brvrwoxd+Ly1rTOjv
 lTYtGMBYLlvRusEaslF9M3qAkYLyylSmrnmJmodXtgr/EKJarcPpDkJD0cJftv/RMwlF
 g9JM7QvPkEg83bJgVgEj7/2X2TBb+1Ak2rk1mlb86jQ8WpCYwMqdhY9g83IiJRGdqfil
 WIbkjuidwYSeFsaLAVRqNAl04OIj4SslcitILDyOsrTbWTgq6SODn0ZpDhuuG2B64GmP
 JJBVS3lkoTE3Btn6uJwxC8ZW6VfzoCqDolBt0oww3NWwBgIsSQsjJdYKdhub7c2Gd1Gb Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn0k503kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:30:04 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATEU39C006644;
        Mon, 29 Nov 2021 14:30:03 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cn0k503js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:30:03 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATERRto025501;
        Mon, 29 Nov 2021 14:30:02 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3ckcaak54m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 14:30:01 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATEU01w60228008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 14:30:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BB2411206B;
        Mon, 29 Nov 2021 14:30:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 522BE112069;
        Mon, 29 Nov 2021 14:30:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 14:30:00 +0000 (GMT)
Message-ID: <1402f334-8072-48d1-b30b-2c2cdd4869dd@linux.ibm.com>
Date:   Mon, 29 Nov 2021 09:30:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
 <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
 <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WaMH4KKwko9ZQ7tLFAvxxCXMeCrZSbEY
X-Proofpoint-GUID: KBjpraKQWZaa9U7HqqQhiEQx1GIysd4A
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111290071
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/29/21 09:10, James Bottomley wrote:
> On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
>> On 11/29/21 07:50, James Bottomley wrote:
>>> On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
>>>> On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley wrote:
>>>>> Currently we get one entry in the IMA log per unique file
>>>>> event.  So, if you have a measurement policy and it measures a
>>>>> particular binary it will not get measured again if it is
>>>>> subsequently executed. For Namespaced IMA, the correct
>>>>> behaviour
>>>>> seems to be to log once per inode per namespace (so every
>>>>> unique
>>>>> execution in a namespace gets a separate log entry).  Since
>>>>> logging
>>>>> once per inode per namespace is
>>>> I suspect I'll need to do a more in depth reading of the existing
>>>> code, but I'll ask the lazy question anyway (since you say "the
>>>> correct behavior seems to be") - is it actually important that
>>>> files which were appraised under a parent namespace's policy
>>>> already
>>>> should be logged again?
>>> I think so.  For a couple of reasons, assuming the namespace
>>> eventually
>>> gets its own log entries, which the next incremental patch proposed
>>> to
>>> do by virtualizing the securityfs entries.  If you don't do this:
>> To avoid duplicate efforts, an implementation of a virtualized
>> securityfs is in this series here:
>>
>> https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
>>
>> It starts with 'securityfs: Prefix global variables with secruityfs_'
> That's quite a big patch series.  I already actually implemented this
> as part of the RFC for getting the per namespace measurement log.  The
> attached is basically what I did.

I know it's big. I tried to avoid having to bind-mount the system-wide 
single securityfs into the container and inherit all the other security 
subsystems' files and directories (evm, TPM, safesetid, apparmor, tomoyo 
[ https://elixir.bootlin.com/linux/latest/C/ident/securityfs_create_dir 
]) and instead have a  'view' that is a bit more restricted to those 
subsystems that are namespaced. The securityfs_ns I created can be 
mounted into each user namespace individually and only shows what you're 
supposed to see without other filesystem tricks to hide files or so. It 
should be future-extensible for other subsystem to register themselves 
there if they have something to show to the user.

    Stefan


