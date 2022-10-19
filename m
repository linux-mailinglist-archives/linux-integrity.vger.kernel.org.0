Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD36049AD
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJSOtj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJSOtX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 10:49:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68FF88D9;
        Wed, 19 Oct 2022 07:37:00 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JEWCub008964;
        Wed, 19 Oct 2022 14:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gQ0LrSPPMFn2K044cE0uzaLohVsC19QuIJLiPg813JU=;
 b=ndV8MqyCeIU1XL0FTgxXLnIvLXFxWbHVYZfPDYVVwdUVkMbBXrq7wRw9yQGzvkirsIaf
 2gyNf++2jz3JLIUzatlz/h3YFrESBDEM3dxBewDCjt7o5iVZoxMbR3M/VGpccmqXluR+
 RYBjUKdz0J0ZZ0CYrO+GXQlTxCk609ZwoV9AZ+UTlnTMVKaxRPpqtZf2H5VUjV0dNUge
 iAfs/GX/8Yw0S5ZccC+MSc5ZdbGinZXQI+QJpesI9hSViw2ZRIDxt6N5R+VntCO9yy/Z
 03gJWHUsYg4I4rz3QeaYTg3xZLn4BvxBTxdVw6VFUzQ940/fXIKdZ859vnxZxtXpg/5A Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kak330d0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:36:39 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29JEX7Ig013830;
        Wed, 19 Oct 2022 14:35:40 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kak3309md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:35:40 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JEKIfR011292;
        Wed, 19 Oct 2022 14:34:52 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3k7mgabb0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:34:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JEYpcx983658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:34:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC9F05805E;
        Wed, 19 Oct 2022 14:34:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3382D58056;
        Wed, 19 Oct 2022 14:34:49 +0000 (GMT)
Received: from sig-9-65-252-68.ibm.com (unknown [9.65.252.68])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 14:34:49 +0000 (GMT)
Message-ID: <16e008b3709f3c85dbad1accb9fce8ddad552205.camel@linux.ibm.com>
Subject: Re: [PATCH 2/9] security: Move trivial IMA hooks into LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Petr Vorel <pvorel@suse.cz>, Borislav Petkov <bp@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 19 Oct 2022 10:34:48 -0400
In-Reply-To: <20221013223654.659758-2-keescook@chromium.org>
References: <20221013222702.never.990-kees@kernel.org>
         <20221013223654.659758-2-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yCJxJtC0CR0Mftu0gWwsAb5HlVqwg9E1
X-Proofpoint-ORIG-GUID: LqgPk_vOKUjAebx2xuWDzUINYmLiEH59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-10-13 at 15:36 -0700, Kees Cook wrote:
> This moves the trivial hard-coded stacking of IMA LSM hooks into the
> existing LSM infrastructure.

The only thing trivial about making IMA and EVM LSMs is moving them to
LSM hooks.  Although static files may be signed and the signatures
distributed with the file data through the normal distribution
mechanisms (e.g. RPM), other files cannot be signed remotely (e.g.
configuration files).  For these files, both IMA and EVM may be
configured to maintain persistent file state stored as security xattrs
in the form of security.ima file hashes or security.evm HMACs.  The LSM
flexibility of enabling/disabling IMA or EVM on a per boot basis breaks
this usage, potentially preventing subsequent boots.
-- 
thanks,

Mimi

