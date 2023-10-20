Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CF97D17F1
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 23:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjJTVVv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjJTVVu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 17:21:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90FD6C
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 14:21:43 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLEbwL015717;
        Fri, 20 Oct 2023 21:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OJqk9oRTwKuB1dVSpV+Rl3kAJfUn/HziALgIchb9yhg=;
 b=ZyW4YlMLLCBMlFa4YluFjx2qPekekMfx066X/hX36iE2IU3z1QECd5rBGLoHAFvLItO9
 P39D6Y/x6ggOFN67BDxZrUDBCuAi7MEkf2C/NKmfKQi+ZVmCWo7Wy15f3vjSj4hgi7Ho
 LpSnlgZYVcKcC1Aat3z+5MI+QErh/c3chNma14wOk98lAdlMqj/OszrSGs68phasftCe
 GjB1GlpSYeaE4/TQguagSaUW8hRagtnIyRHLnh8FQimtUMQLr8epflazSlF8zUT1ODpM
 obq91f7LOn+PNnOeyUF3t0NXM4rQY8/PD7Xs1V9efgkZpryWZDIQjd4YqCD3gv93lWfE Jg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tv19q872d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 21:21:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39KKY0q8029895;
        Fri, 20 Oct 2023 21:21:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc47qdf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 21:21:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39KLL9av5178036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 21:21:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3225858059;
        Fri, 20 Oct 2023 21:21:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 419815804B;
        Fri, 20 Oct 2023 21:21:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 20 Oct 2023 21:21:08 +0000 (GMT)
Message-ID: <f60a08b3-408b-05e0-2c91-9c19159c7fd2@linux.ibm.com>
Date:   Fri, 20 Oct 2023 17:21:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
 <2c06f9c5-6f3a-b163-20ca-24178d7cba4e@linux.ibm.com>
 <9b227c0a-ddb3-b1c3-4ed0-e3e740db7788@linux.microsoft.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <9b227c0a-ddb3-b1c3-4ed0-e3e740db7788@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QrmFz3OpKob0DBTxcJcEGDoqRDdenUNx
X-Proofpoint-GUID: QrmFz3OpKob0DBTxcJcEGDoqRDdenUNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=957 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200180
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/20/23 16:33, Tushar Sugandhi wrote:
> Thanks a lot Stefan for reviewing this series.
> Really appreciate it.


You are welcome.

What may be a bit problematic is the fact that between the time the 
buffer for the flattened IMA log is allocated (kexec 'load') and the 
time it is filled (kexec 'exec') that the log may grow quite a bit. I 
would say that the size of the growths may depend a lot on how people 
are using their system that the additional kilobytes  may or may not be 
enough. So a distro would probably have to specify additional bytes to 
allocate for like the worst case. But how many kilobytes is the worst case?

    Stefan

