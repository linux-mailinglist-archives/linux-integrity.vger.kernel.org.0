Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7078DCE0
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbjH3Sqw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 14:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjH3SM4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 14:12:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B4132;
        Wed, 30 Aug 2023 11:12:54 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UI750B030917;
        Wed, 30 Aug 2023 18:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=s+MNKJLQTeg78SAaJFKITDLpr8wU3HO5AJ+NuOq6bfc=;
 b=gjhCqsr4HwNBsBSilamLXlAqQieiJ2223b7kO2SSa1sJ3IwisewynMfOdnbtcWvmdDra
 ms06fLQG6cD4camOzIo213FhskAFfbpQqb+HqElV+IS6jsqxTzy1fZUG6fCIPtipnAna
 E26gSSHIcowkVB9YY7N24AbfdIHSSXiN3GO2EDvieKsKSapeNd0+LmUWrhyw5HghsArL
 2zPKU58J1jKfQBid31EKu8IdZAoH1JTnuai/tOr5dJvR35+pUDrqnixCRcfQqdEq4Oac
 X/DFukDjPXo1+zUgYELF7E5Vgpk1UiOxFRIFzxtpN/ILNxGXoSPqT8QsR6s+EBQ8XTlf 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st71e6a9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:12:29 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UI7Bhj031418;
        Wed, 30 Aug 2023 18:12:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st71e6a9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:12:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UGDvLs009941;
        Wed, 30 Aug 2023 18:12:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7knrkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:12:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UICRXX32244444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:12:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D496458055;
        Wed, 30 Aug 2023 18:12:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF16358059;
        Wed, 30 Aug 2023 18:12:26 +0000 (GMT)
Received: from [9.67.11.225] (unknown [9.67.11.225])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Aug 2023 18:12:26 +0000 (GMT)
Message-ID: <598fdd62-f4c3-a6dc-ae22-8f5a9e18f570@linux.ibm.com>
Date:   Wed, 30 Aug 2023 14:12:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - aggregate
Content-Language: en-US
To:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BIukSM_f8IdJDmNpvoSVCXl9MVpSVhR1
X-Proofpoint-GUID: m5aNa6GyTf1iNm99yZoM_InKKuTN_F8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=909 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300165
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
> - A user-mode process will trigger the snapshot by opening a file in SysFS
>    say /sys/kernel/security/ima/snapshot (referred to as 
> sysk_ima_snapshot_file
>    here onwards).
> - The Kernel will get the current TPM PCR values and PCR update counter [2]
>    and store them as template data in a new IMA event "snapshot_aggregate".

If this is relying on a user-mode process, is there a concern that the 
process doesn't run. Might it be safer to have the kernel trigger the
snapshot.

PCR reads are not atomic, with each other and with event log appends. 
Is this an issue?

The PCR update counter can change between PCR reads.  What is its purpose?

What is the purpose of the snapshot aggregate?  Since the entire event 
log has to be retained and sent to the verifier, is the aggregate redundant?

