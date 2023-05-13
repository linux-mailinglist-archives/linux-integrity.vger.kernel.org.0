Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466B07019E5
	for <lists+linux-integrity@lfdr.de>; Sat, 13 May 2023 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjEMUu4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 May 2023 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjEMUux (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 May 2023 16:50:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC5B3ABE;
        Sat, 13 May 2023 13:50:32 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34DKd27F023684;
        Sat, 13 May 2023 20:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=I27LXEJntY2DfEoNMiFVMi2f4t0raGMYhUupEu65Rnk=;
 b=WrWe6YRybHOEhQlBLFLKLkF12zkQ+VaRVMpMRGL/l9vGnEcpY8+69uLRFn5a4NNOLymc
 tjBwLT+G382oIJLhgbsOmngIoPvb5e/lM72pLvNVeqfg/qtW34gBOrf3V8cbUG7mmBh2
 ODU5505YwjrFhkBQOTqoSmis12EDzJPJIPCGbUdSX4iVupPtAoqnB7dNyg7sQWPOlHEM
 r8Dc396Oseefdr8va3dS5lGeWNHmY6usfcySflCdp8ulH3sUhX6mQkYsYuaELboytbAW
 jL5gctqUj0g4fwKNR0DTNHFkTst24B1uChJ3JCYKf4s0/hArsUChxj0XrsA8vTkAxtUm Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qj3cjn88c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 20:49:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34DKg8pr031011;
        Sat, 13 May 2023 20:49:21 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qj3cjn882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 20:49:21 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34DHwSpG025221;
        Sat, 13 May 2023 20:49:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qj265c6uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 20:49:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34DKnJu61376812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 May 2023 20:49:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26C9958056;
        Sat, 13 May 2023 20:49:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A35905803F;
        Sat, 13 May 2023 20:49:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 13 May 2023 20:49:18 +0000 (GMT)
Message-ID: <4651cf1c-423d-05c2-b4c3-9d829a2eadf4@linux.ibm.com>
Date:   Sat, 13 May 2023 16:49:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tpm_vtpm_proxy: fix race condition in /dev/vtpmx creation
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230513172818.752712-1-jarkko.sakkinen@tuni.fi>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230513172818.752712-1-jarkko.sakkinen@tuni.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oz8RkJ5B5Aw2orpsZgYZagNJNyQAqtrK
X-Proofpoint-GUID: KqGggd8sB_JG8SF7ZRCAI0ZHu5ruDStp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-13_16,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=741 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305130193
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/13/23 13:28, Jarkko Sakkinen wrote:
> /dev/vtpmx is made visible before the workqueue exist, which can lead

which can lead to

> memory corruption in the worst case, if workqueue is used before it has
> been fully initialized. Address this by changing the call order.
> 

Thanks,
    Stefan
