Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A178C6F6
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Aug 2023 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjH2OKc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Aug 2023 10:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjH2OKJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Aug 2023 10:10:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB89D
        for <linux-integrity@vger.kernel.org>; Tue, 29 Aug 2023 07:10:06 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TDwn6F025918;
        Tue, 29 Aug 2023 14:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vQ1KYdURn9r1HcC+S7oO8DIZcmU0Mu0nckyChSkVDIE=;
 b=MWzbNVybp59XOBA+y/LrkHsgOmxbDwUVhtSk/yzDfL6oqPif1KgFH+rTEUlY9tu6WDXW
 8XO2gS99lR0N+lQV2raDKetDUKJxG6/wGUsQs5bOoUafL/YwhSOOsgJg7M9mGe3d/ar3
 IsUebTPKF632gaFmgoe4JFuAHvVuCZvCN0ue0Ud5Na3ShazYNL+MGJe2gOxQBuxiCCtK
 ayhBNnYK5bkc0F4Z2S0Ge+FTakXL5LeAzpnMQEZTEwyjeJTufbW2ql5WSUFLbIj+TOfN
 wNFnL1sqoVkF0KMvwZ7Kv3L+W1QAqjgIRLMiAziTaiCj4A2SeSViTp1Klocc4BTb1kaK +g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssht20xjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 14:09:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TE7NXl004891;
        Tue, 29 Aug 2023 14:09:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqsm8vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 14:09:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TE9qYr61604348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 14:09:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF88958066;
        Tue, 29 Aug 2023 14:09:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8249A58065;
        Tue, 29 Aug 2023 14:09:51 +0000 (GMT)
Received: from [9.67.37.59] (unknown [9.67.37.59])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 14:09:51 +0000 (GMT)
Message-ID: <28aefb27-8f8c-e77e-4e21-8b467738dce1@linux.ibm.com>
Date:   Tue, 29 Aug 2023 10:09:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, GUO Zihua <guozihua@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-integrity@vger.kernel.org
References: <20230817061334.1910-1-guozihua@huawei.com>
 <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ezL7VRMnQ4fwU0o9VBMi_ddzy1mM5pGW
X-Proofpoint-GUID: ezL7VRMnQ4fwU0o9VBMi_ddzy1mM5pGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=747 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290121
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/17/2023 10:19 AM, Mimi Zohar wrote:
> Before we can introduce this sort of change, we would need to introduce
> an IMA measurement list version.  Perhaps its time to define an IMA
> security critical-data record, which would include this and other
> information.  The measurement list itself would need to include a
> version number.

FYI, the TCG specified UEFI event log has a standard first record.  The 
events themselves do not have a version number.

That first record is itself versioned, so it can change over time.

The record has various version numbers, a count of PCR banks, a mapping 
from algorithm number to algorithm size, and a sized vendor specific area.

