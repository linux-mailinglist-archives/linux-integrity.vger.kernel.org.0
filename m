Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05F562C582
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 17:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiKPQzh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Nov 2022 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiKPQzR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Nov 2022 11:55:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6574C275;
        Wed, 16 Nov 2022 08:54:29 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGGfGtg010470;
        Wed, 16 Nov 2022 16:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aqZW4skJIW0nfSiVSoLe7Vw4B/k5hMwSdTc7CX1lIx4=;
 b=WvYphjuJzgjqxvZmmJyexhMUD6m9YnZUScjSyxB/poWro2tDYvpvCCJfgXT3sH7OVqkv
 9+w+tENqabf4OjK3CiGtuU+aMx2d1EBh1Y5K5jcVAaD8VpVLYqfKHBu3b1T29JnhMCK+
 /CN6cn6JhHs0xQ9GTDo1GU3Gma+rFTjp++TWjm50t7mEdTfc0FW6/86Di930qWxR9VOM
 is77L63aigE4mGrwF63jaw5vttEDIzczenaQhXnnWZjB6zuixta6dP41g97RV6PMDfD9
 AoWl9CHuP0b5928Dl+axY/h7DHtWtTl98wfQEf0u6hn+6UfrMKO9GJnDt7FyOSzLISiA DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw3ktgbdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 16:54:10 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGGgbu7018969;
        Wed, 16 Nov 2022 16:54:09 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw3ktgbdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 16:54:09 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGGokPB007689;
        Wed, 16 Nov 2022 16:54:09 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 3kt34abppg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 16:54:09 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGGs7M458982778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 16:54:08 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C44625804B;
        Wed, 16 Nov 2022 16:54:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF1D858065;
        Wed, 16 Nov 2022 16:54:06 +0000 (GMT)
Received: from sig-9-77-134-48.ibm.com (unknown [9.77.134.48])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 16 Nov 2022 16:54:06 +0000 (GMT)
Message-ID: <a50ddd918933b1a5b181aeb6b30301f78eefa192.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: Fix memory leakage in keyring allocation
 error path
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, dmitry.kasatkin@gmail.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Nov 2022 11:53:56 -0500
In-Reply-To: <20221111101317.5468-1-guozihua@huawei.com>
References: <20221111101317.5468-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GMLEYYsFpfuBDeyNhtve6gYEKzz-Ktp4
X-Proofpoint-ORIG-GUID: FHy31tJ5l9TrBVxrpO2_F_ep6KoAdHKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxlogscore=849 lowpriorityscore=0
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-11-11 at 18:13 +0800, GUO Zihua wrote:
> Key restriction is alloced in integrity_init_keyring(). However, if
> keyring allocation failed, it is not freed, causing memory leaks.
> 
> Fixes: 2b6aa412ff23 ("KEYS: Use structure to capture key restriction function and data")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

Thanks, applied.

Mimi

