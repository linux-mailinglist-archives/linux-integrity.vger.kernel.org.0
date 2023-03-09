Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D46B17CA
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Mar 2023 01:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCIAXp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Mar 2023 19:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCIAXo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Mar 2023 19:23:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B66486F;
        Wed,  8 Mar 2023 16:23:42 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328NQ3MO012078;
        Thu, 9 Mar 2023 00:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ow1SlrV3VkY4IMsLryNLahQ4dIZNZmzPOnahCnP8KdM=;
 b=Rr39/ZR+twTBGooUxR9g/sR6GzGyF5zEqs39hqTfwKYv/hVQbllDOWkeo31X4cu0C66L
 +L72tROPD+XZicRQeho5gauxa5NoODJFj82ozxiDtwl0xLrNITSt1IuqzwNtL5L8IvUI
 krfHQOCPgUF6TTfqZmW1mCauBw58CFFpqIbWCUenCZ2Encf65gDXQU221weHS6/MpAG9
 yEM3Y5Ztk8keT80t0PySpL8z6SY0uuJLMfpc6QHEhPCbWXwymtDRUdRQOfJ4Vb4kO8Xa
 rxWzMO23Pa6hTXFcpYsIHSHEOK0jURBqnnSYBDNujpn/McCw/OtPYOqZa62fLhm13E/D WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6ry3u08n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 00:23:20 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3290Mxhg030392;
        Thu, 9 Mar 2023 00:23:20 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6ry3u08c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 00:23:20 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328NlIh6016691;
        Thu, 9 Mar 2023 00:23:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3p6fhk68v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 00:23:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3290NHZx6160992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 00:23:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EA1358061;
        Thu,  9 Mar 2023 00:23:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 702005803F;
        Thu,  9 Mar 2023 00:23:16 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 00:23:16 +0000 (GMT)
Message-ID: <b8ed9f24e051158580c561a8d8863622ba2f4c8e.camel@linux.ibm.com>
Subject: Re: [PATCH v2] security: Introduce LSM_ORDER_LAST and set it for
 the integrity LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 08 Mar 2023 19:23:16 -0500
In-Reply-To: <20230308171119.1784326-1-roberto.sassu@huaweicloud.com>
References: <20230308171119.1784326-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c-VbPkxHX5k1D9-kLy0mz-FB7xTTCgW4
X-Proofpoint-ORIG-GUID: fDqI-sBskH4SOAuOpEB0E9XinzmYVQHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=555 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080202
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-03-08 at 18:11 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
> the last, e.g. the 'integrity' LSM, without changing the kernel command
> line or configuration.

^needing to be last

> 
> Also, set this order for the 'integrity' LSM. While not enforced, this is
> the only LSM expected to use it.
> 
> Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> and put at the end of the LSM list.
> 
> Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> LSM is found, regardless of its order. In this way, the kernel would not
> wrongly report that the LSM is not built-in in the kernel if its order is
> LSM_ORDER_LAST.
> 
> Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.  With this patch, 'integrity' can be safely removed
from CONFIG_LSM definitions.

-- 
thanks,

Mimi


