Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52880660A2B
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Jan 2023 00:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjAFXRs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Jan 2023 18:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFXRr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jan 2023 18:17:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DECD848FE
        for <linux-integrity@vger.kernel.org>; Fri,  6 Jan 2023 15:17:46 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306LeLUt005053;
        Fri, 6 Jan 2023 23:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+jKBrAshIvnUC+FbwQdll3p6grPQxmofw1cvlR/I+/c=;
 b=Xe2QVNaVxfxeKq3J64Awuo++1h+Lhno8S/fS9YhC0AkICi+ZKnKTJFkmW/wt6xdp5xcz
 o9Z4ApCDavsDYfHeFR+pw/4j26pu3pORG0U03WCNwzF3baIJcNNaewjY8c0lhpz/z7yl
 cE0XHIZdy4KGEbjH0kG7HZVLWxEPcJXpAPEzhlwUZa603H4ItiWDXaDKLDHXsxNE+tx9
 9crxbLXSSY8l6bLtyJSOL5rQaNd07JJk43Uv1THhSoZ5junXlJcUlXuZB1JUzUUAhYsH
 +2cBquT/JYU4o9ER8yALz4+aQrn3xwqrOGraHUBx78W5TXwrmxW1tX+XNP1HU9EErDYk wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mxh416rqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 23:17:43 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 306NHhcC009962;
        Fri, 6 Jan 2023 23:17:43 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mxh416rqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 23:17:43 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 306KL5tJ007032;
        Fri, 6 Jan 2023 23:17:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3mtcq8yf0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 23:17:42 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 306NHeVG55443824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jan 2023 23:17:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1F1758064;
        Fri,  6 Jan 2023 23:17:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55DC858056;
        Fri,  6 Jan 2023 23:17:40 +0000 (GMT)
Received: from [9.160.181.79] (unknown [9.160.181.79])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jan 2023 23:17:40 +0000 (GMT)
Message-ID: <25e8bd43-f73c-f3b0-bec7-32e9b3a5b876@linux.ibm.com>
Date:   Fri, 6 Jan 2023 18:17:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Seal/Unseal trusted keys against PCR policy
Content-Language: en-US
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>,
        linux-integrity@vger.kernel.org
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
 <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
 <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
 <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
 <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com>
 <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7BsAB2E6ZUjNRUDOUO0PJW8KBc_7y4d-
X-Proofpoint-ORIG-GUID: -9PTnx9mR5ivPXfmQqdPt-XD5xofnAX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I discourage anyone from using scripted command line tools as production 
code.  IMHO, they're fine for learning and prototyping but that's all.

On 1/6/2023 5:23 PM, William Roberts wrote:
> If you need to do this in production that tpmproxy allows anyone to
> connect to it. So while it's open it
> would circumvent the permissions on /dev/tpmrm0. You can just use
> tpm2-tools, which uses
> contexts and avoids this problem.
