Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1C5FD356
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Oct 2022 04:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJMCrl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Oct 2022 22:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJMCrk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Oct 2022 22:47:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55063125027;
        Wed, 12 Oct 2022 19:47:39 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CNlAHU023701;
        Thu, 13 Oct 2022 02:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jFYT+lLgRKtbF2u6kETVU1lTb/l+GD2DYOhBdUsU0qA=;
 b=TN44X2jxaTt4y2CeYXPVrKdRS3eUa1gVtsf73AHwy0jofqkYUSAxkG/mEFYdbM6HtJxM
 wxL6uE41xhDwZCJ+FsMVY7ho225oLj8dwZp0TLYUHqS+WCJtzAOruZjaNvAuhEhCF2ad
 M+olU4ndFpQ9tcbV2jyJ/dTBbrxEeO2yDp393TrVQrYQhjSHuw0WMXCoSGj+5hzeMcbk
 s9s0Jp/KBOWovKBrUblTHa6yCxZAA4zWZI6YbcTcha2+FCWLWkQpOjjPJL4nudMifP2y
 szrfsSRnzLKICrBsBA3SUGNx5w4fbq7auFyIjMBoK2Hq62iYhdQbHajR07WnXodXPwIh vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k67j63jy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 02:47:21 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29D2MRHH018416;
        Thu, 13 Oct 2022 02:47:21 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k67j63jxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 02:47:21 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29D2bA9E026987;
        Thu, 13 Oct 2022 02:47:20 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3k30uac7w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 02:47:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com ([9.208.128.131])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29D2lJ5g23593642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 02:47:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A7FB58052;
        Thu, 13 Oct 2022 02:47:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B94DC5804E;
        Thu, 13 Oct 2022 02:47:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.173.1])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 13 Oct 2022 02:47:17 +0000 (GMT)
Message-ID: <ca642045c0725c045b165f9daef03bd413c6850a.camel@linux.ibm.com>
Subject: Re: [PATCH v2] KEYS: encrypted: fix key instantiation with
 user-provided data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nikolaus Voss <nv@vosn.de>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 12 Oct 2022 22:47:17 -0400
In-Reply-To: <20221012151429.391EE9BB@mail.steuer-voss.de>
References: <20221012151429.391EE9BB@mail.steuer-voss.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W6gsF4LRdvLv8sym25qjn9p-SvZQw-fx
X-Proofpoint-ORIG-GUID: hy3OKS98nOUtrZ6P0jWI22-PFUxbUe7w
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_01,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Nikolaus,

On Wed, 2022-10-12 at 17:09 +0200, Nikolaus Voss wrote:
> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> decrypted data") added key instantiation with user provided decrypted data.
> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> Fix this to use hex2bin instead.
> 
> Keys created from user provided decrypted data saved with "keyctl pipe"
> are still valid, however if the key is recreated from decrypted data the
> old key must be converted to the correct format. This can be done with a
> small shell script, e.g.:
> 
> BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
> NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c64)
> keyctl add user masterkey "$(cat masterkey.bin)" @u
> keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u
> 
> It is encouraged to switch to a new key because the effective key size
> of the old keys is only half of the specified size.

Thank you for updating the patch description.

> 
> The corresponding test for the Linux Test Project ltp has been fixed
> with this patch:
> https://lists.linux.it/pipermail/ltp/2022-October/031060.html

Perhaps make this a "Link:" line and move it before your "Signed-off-
by".
> 
> Changes
> =======

As per Documentation/process/submitting-patches.rst, the changelog
belongs after the "---" separator. 

> v2: - clarify commit message, add example to recover old/broken keys
>     - improve example in Documentation/security/keys/trusted-encrypted.rst
>     - add link to ltp patch
> 
> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> ---
>  Documentation/security/keys/trusted-encrypted.rst | 3 ++-
>  security/keys/encrypted-keys/encrypted.c          | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 0bfb4c339748..e81e47db0b4c 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -350,7 +350,8 @@ Load an encrypted key "evm" from saved blob::
>  
>  Instantiate an encrypted key "evm" using user-provided decrypted data::
>  
> -    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypted_data.blob`" @u
> +    $ evmkey=abcdefABCDEF1234567890aaaaaaaaaaabcdefABCDEF1234567890aaaaaaaaaa
> +    $ keyctl add encrypted evm "new default user:kmk 32 $evmkey" @u
>      794890253

As example code is often re-used, I would avoid including the key data
on the command line.

-- 
thanks,

Mimi

