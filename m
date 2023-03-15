Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230056BA3F8
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Mar 2023 01:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCOARx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 20:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCOARw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 20:17:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A61410AF;
        Tue, 14 Mar 2023 17:17:51 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ENoJOM022049;
        Wed, 15 Mar 2023 00:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/xItYpSlSXkmWgakFckcb3pK1C/l+P6F65k0vZXytZM=;
 b=cQpS/M/zG/RUYfGbyRjjq7Ih20/9UjnZbkazNBd0rqmPW2iuyoZ+Ejv5DCXKEurlVvc7
 qF599/eYwsZ1Nyg7tCRADdpfGbGH4CH5TfFJ7sszyk98g4Zj9+kCYYLe3gm4egyNJU2R
 9DW91NQnkELVLtZ49zBxwUJloXhuDrakI+CC143ha5AvjlI/R4TFg/kRE2qnJVCFXDhd
 M8Uvt3jyIlVjRZGg7glkIYAs5SY5BJ2qijErPvqjtoVo4hN/LVCingOSyDGAmiRfLFR2
 K4jIiogF2MCp5gq+y8jzicOLY/h3BD3HtxCOCfswuW+glJRFPCKlXB4hM2YESUfxJmrw dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pb2xx8h5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 00:17:06 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32ENoa4M022881;
        Wed, 15 Mar 2023 00:17:06 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pb2xx8h5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 00:17:05 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32EN5hOB010490;
        Wed, 15 Mar 2023 00:17:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pb29tgbcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 00:17:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32F0H31I11469482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 00:17:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAA8358067;
        Wed, 15 Mar 2023 00:17:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0711758056;
        Wed, 15 Mar 2023 00:17:03 +0000 (GMT)
Received: from sig-9-65-194-57.ibm.com (unknown [9.65.194.57])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Mar 2023 00:17:02 +0000 (GMT)
Message-ID: <ef330bdbf0e0a176a2e5c32121e86dc2c46934b6.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix potential NULL pointer access in
 ima_match_rules()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roman Danilov <romanosauce57@gmail.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        GUO Zihua <guozihua@huawei.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Date:   Tue, 14 Mar 2023 20:17:02 -0400
In-Reply-To: <20230314180308.17909-1-romanosauce57@gmail.com>
References: <20230314180308.17909-1-romanosauce57@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fm_xGXehMN9UzVFo63IadlZq9xz4Z9dw
X-Proofpoint-GUID: ynuiJB6pcg0-dg7-GWNRj44cQqznIre7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_15,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=810 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303140189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-03-14 at 21:03 +0300, Roman Danilov wrote:
> In ima_match_rules(), when ima_lsm_copy_rule() fails, NULL pointer
> is assigned to lsm_rule. After that, in the next step of the loop
> NULL pointer is dereferenced in lsm_rule->lsm[i].rule.

I must being missing something.  The next step of the loop tests
whether rule_reinitialized is set before accessing lsm_rule-
>lsm[i].rule.

> 
> As far as ima_match_rules() is not designed to return error code,
> add __GFP_NOFAIL to make sure memory allocation succeeds.

Using  __GFP_NOFAIL here would be safer.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> Signed-off-by: Roman Danilov <romanosauce57@gmail.com>
> Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

-- 
thanks,

Mimi

