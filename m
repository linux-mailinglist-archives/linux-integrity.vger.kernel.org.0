Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D38513E4C
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Apr 2022 00:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347740AbiD1WL5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Apr 2022 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347530AbiD1WL5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Apr 2022 18:11:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72ABCB5E;
        Thu, 28 Apr 2022 15:08:39 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SKf2bt003777;
        Thu, 28 Apr 2022 22:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kCWBkV9EBURXMYT9kDz54RHvpVE/FsInuBtEK/b+Bg4=;
 b=CzK9bOB6HYT2CMnz65Rmgq5Ex9Ni07yj09ysM8kdMosoxiTsBYwyRjkPIgbGx0Jyv36I
 yeF5/Sv2YVbZBnc992PsKUkkMzAhbjES3qxr2DcsC38DtVZZ1HikWS1TLNhYvxG7QoBx
 ROb7kN04jkLsB/J81wiuFuJ6vJOea/SoR/koeZnu6GYLZE+CXaBfJ+8vFdnnBZWvyWOQ
 00niJ4yiDXztcyNSfLiyemnaqHk+k4Z8f+BX9cIU50NiuLX7EO3LLaU6QzfazUQcYLwB
 NgcFOfeTWeTRLYrZ2jsGYVUc5vMoMYQFah/LvAolXSDtV1kQlIcGCGOaSV2JDCddiPrR 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqt9dwp3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 22:08:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23SLn3eF005352;
        Thu, 28 Apr 2022 22:08:21 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqt9dwp3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 22:08:21 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23SLgXlH032529;
        Thu, 28 Apr 2022 22:08:20 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3fm93aq30c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 22:08:20 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23SM8Jj436438418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 22:08:19 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA3E26E054;
        Thu, 28 Apr 2022 22:08:19 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A7106E04E;
        Thu, 28 Apr 2022 22:08:19 +0000 (GMT)
Received: from [9.211.77.121] (unknown [9.211.77.121])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Apr 2022 22:08:19 +0000 (GMT)
Message-ID: <0c6442db-7e97-58dd-f39c-b22a37398715@linux.vnet.ibm.com>
Date:   Thu, 28 Apr 2022 18:08:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] integrity: Allow ima_appraise bootparam to be set when SB
 is enabled
Content-Language: en-US
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com
References: <20220425222120.1998888-1-eric.snowberg@oracle.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20220425222120.1998888-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rimEikXrGxHYx5taUsRDOxhOxtqdH1iw
X-Proofpoint-ORIG-GUID: mAlKens8YqIG3yS2DPKRj9XhK_OYTk1h
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_05,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/25/22 18:21, Eric Snowberg wrote:
> The IMA_APPRAISE_BOOTPARM config allows enabling different "ima_appraise="
> modes (log, fix, enforce) to be configured at boot time.  When booting
> with Secure Boot enabled, all modes are ignored except enforce.  To use
> log or fix, Secure Boot must be disabled.
>
> With a policy such as:
>
> appraise func=BPRM_CHECK appraise_type=imasig
>
> A user may just want to audit signature validation. Not all users
> are interested in full enforcement and find the audit log appropriate
> for their use case.
>
> Add a new IMA_APPRAISE_SB_BOOTPARAM config allowing "ima_appraise="
> to work when Secure Boot is enabled.

Tianocore(UEFI Reference Implementation) defines four secure boot modes, 
one of which is Audit Mode. Refer to last few lines of Feature Summary 
section in Readme.MD 
(https://github.com/tianocore/edk2-staging/blob/Customized-Secure-Boot/Readme.MD#3-feature-summary). 
Based on the reference, IMA appraise_mode="log" should probably work in 
coordination with AuditMode.

Thanks & Regards,

     - Nayna

