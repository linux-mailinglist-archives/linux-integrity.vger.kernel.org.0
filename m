Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A572B672938
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 21:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjARUYH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 15:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjARUYF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 15:24:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4F85356B;
        Wed, 18 Jan 2023 12:24:03 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IIOelA030659;
        Wed, 18 Jan 2023 20:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XrsPjAfjNYVpI0CBxJ+6XW0c7xBfNRTLwjUs9hVrdos=;
 b=taIFUGfF2t91/32Qj0yX7hJn+6ygpO6CzL+ER/cOYw4I/Bmn4TJHo9vXM2Y9SpOsQ8bY
 ta/r9RZDJrrxfta+u/OfXhwkTjQMneE/S7GyKODZsLbLc0L5wZQdQNpKDMyTUbXfmSvR
 SW0IBAozg44KMLE11Wm31TdCp242OW9x4o0Ql/Fgf+bQWhYqd+XQmS7AnmyCLZaXwydE
 g/wmA2jRRVvLmOLKJY3Unh0Ae6ZJkwEJBMG0vI1EPpbm2A1/dIxyxeGjhNTn8gohNjUV
 /PLNvnnlko3azrZBT39qDFU1gqvyv0PBDIGN3Tr+YmtQMtDwEZfCw8+fLT1LNNU7SK4r uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6hem2faq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 20:23:48 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30IKHf9K011612;
        Wed, 18 Jan 2023 20:23:47 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6hem2fad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 20:23:47 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30IK7SiA005708;
        Wed, 18 Jan 2023 20:23:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3n3m17qq7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 20:23:46 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30IKNjS8262694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 20:23:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11E345805C;
        Wed, 18 Jan 2023 20:23:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D92FB5805A;
        Wed, 18 Jan 2023 20:23:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.7.111])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 20:23:43 +0000 (GMT)
Message-ID: <ba437ae5bd782ec2a6a8351f4c667aa16014af97.camel@linux.ibm.com>
Subject: Re: [PATCH -next] evm: Support small xattr in dump_security_xattr()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Jan 2023 15:23:43 -0500
In-Reply-To: <20221226102419.16189-1-xiujianfeng@huawei.com>
References: <20221226102419.16189-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QVl3p5LspGjUqoPehqRSDQLvJBQLcXyr
X-Proofpoint-GUID: HoT13UCoBDTOHLH5VTXd3u0LFDCHQgK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=763 impostorscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301180169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Xiu,

Thank you for cleaning up the code.  The purpose of this patch is to
remove code duplication.   Perhaps rename the patch to "evm: call
dump_security_xattr() in all cases to remove code duplication".

On Mon, 2022-12-26 at 18:24 +0800, Xiu Jianfeng wrote:
> Currently the debug function of dumping xattr is splited into two parts,
> when the length of xattr is less than 64 bytes, it uses pr_debug()
> directly. Merge it into dump_security_xattr() to simplify the code, no
> functional changes here.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Please reword the patch description in terms of removing code
duplication.

-- 
thanks,

Mimi

