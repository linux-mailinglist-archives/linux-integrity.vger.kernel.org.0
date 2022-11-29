Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B7E63C257
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Nov 2022 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiK2OVE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Nov 2022 09:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiK2OUr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Nov 2022 09:20:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE46D68C5A;
        Tue, 29 Nov 2022 06:18:41 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATEDiGK023926;
        Tue, 29 Nov 2022 14:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=wYoNHGUaHFehdnzNT3PBL/KGIrZnJf8txpR6vJqabvQ=;
 b=E7WzhtOpiDo/4PNMBPZG0EpV+5dS+++/e3cDSJL6iFJURtrckOZprQhP9aVkDquQURbn
 YFg6MUojA1mslCFIPNBgJP6g4pSlCG7DkvdT+Eix3RBEn1ZFyX+lFqn9mPRlITJ5inhP
 avMjpsHRCb79j9UZTgc7TkZdnLqdzfsu9GUqIe8q6A3OjVxh1xCcKUlji9ardH7V7B07
 7zvAkuuOFUZcAp+js8KtWYusRNSGGSRqfkJ4fCFR69HWp1P+END4fZfc8PxvB8oSfV+v
 2rWjFyovRnEQHLNkBxQXMIXOyOhWSPIefHYXrd5MsW8QAChGuozvjw1sECl4mwimpkj5 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5kmv07hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:18:35 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ATEGsI2009705;
        Tue, 29 Nov 2022 14:18:35 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5kmv07h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:18:35 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATE5v9H015753;
        Tue, 29 Nov 2022 14:18:34 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3m3aea261c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 14:18:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATEIUCa31195624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 14:18:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5709758067;
        Tue, 29 Nov 2022 14:18:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12EDB58059;
        Tue, 29 Nov 2022 14:18:31 +0000 (GMT)
Received: from sig-9-65-233-5.ibm.com (unknown [9.65.233.5])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Nov 2022 14:18:30 +0000 (GMT)
Message-ID: <d982f5162b4b0486d6b5b0d8f3cfa320e8edf537.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix hash dependency to correct algorithm
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 29 Nov 2022 09:18:30 -0500
In-Reply-To: <20221125121840.88176-1-tianjia.zhang@linux.alibaba.com>
References: <20221125121840.88176-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nXLITWukiqoeofuKsKjrFU5Ile2WHWoS
X-Proofpoint-ORIG-GUID: 1g2ahZTKKgkxsG9pUrDuSxKd493rxSsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_08,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1011 mlxlogscore=827 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-11-25 at 20:18 +0800, Tianjia Zhang wrote:
> Commit d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory") moves
> the SM3 and SM4 stand-alone library and the algorithm implementation for
> the Crypto API into the same directory, and the corresponding relationship
> of Kconfig is modified, CONFIG_CRYPTO_SM3/4 corresponds to the stand-alone
> library of SM3/4, and CONFIG_CRYPTO_SM3/4_GENERIC corresponds to the
> algorithm implementation for the Crypto API. Therefore, it is necessary
> for this hmodule to depend on the correct algorithm.
> 
> Fixes: d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory")
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: stable@vger.kernel.org # v5.19+
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Thanks, Tianjia.

