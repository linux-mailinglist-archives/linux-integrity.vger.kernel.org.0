Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76F86608F2
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jan 2023 22:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjAFVwd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Jan 2023 16:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAFVwc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jan 2023 16:52:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D862ACC
        for <linux-integrity@vger.kernel.org>; Fri,  6 Jan 2023 13:52:31 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306LeEqT004816;
        Fri, 6 Jan 2023 21:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IGe3IBvx2eTKFovj910/Ml+tPXJgCFO2esPG94+bNUc=;
 b=AriDQ6xRz9Birbe+IuDkvb+Ve9K1mCZimflZbzWGLAIKRHMvvgCTZUbG6EfFi/jW/YFQ
 mOucR3i69hFC21jQuadg0/0EYCXeXZX4czoY3ikm4l2Kz6Irt9avZd5ugMQz1IGvhM5P
 YHw+eiQknGJxq+GsYMTyII6+/l6nzhrKngU8c+HWJ7KS/CnRsmgcVSJGTNmllqbdgDC2
 vubF+IaT4i/+Y06cDU45zpqOg16W3XFZFDZ+AFZtdGaPSHP4fwApGO9SRzWYOO10jjxi
 IvuaPDrNK6FZn25mH3lyPwWooc5liPp1/BUxzFWF+SELusZHlYOWlFqSDp5j+qa6Y27Y UA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mxh4159qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 21:52:29 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 306KiWHJ007456;
        Fri, 6 Jan 2023 21:52:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3mtcq8y295-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 21:52:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 306LqRd836897194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jan 2023 21:52:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12DC858054;
        Fri,  6 Jan 2023 21:52:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC09558058;
        Fri,  6 Jan 2023 21:52:26 +0000 (GMT)
Received: from [9.160.181.79] (unknown [9.160.181.79])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jan 2023 21:52:26 +0000 (GMT)
Message-ID: <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com>
Date:   Fri, 6 Jan 2023 16:52:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Seal/Unseal trusted keys against PCR policy
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Cc:     linux-integrity@vger.kernel.org
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
 <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
 <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
 <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
Content-Language: en-US
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9bb8EbAmLUxpC54h3WNYXbnUGuWlaG_I
X-Proofpoint-ORIG-GUID: 9bb8EbAmLUxpC54h3WNYXbnUGuWlaG_I
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060167
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/28/2022 5:48 PM, James Bottomley wrote:
> The main thing you have to do is connect to the TPM not through the
> resource manager so the policy session survives multiple commands
>
> export TPM_DEVICE=/dev/tpm0

Just FYI, as James says, command line utilities interact with the 
resource manager.  When I want to run command line programs through the 
resource manager, I use a proxy to keep the /dev/tpmrm0 session connected.

https://github.com/kgoldman/ibmtss/blob/master/utils/tpmproxy.c holds an 
open source proxy.

