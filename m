Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F405B9A35
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 13:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIOL7E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 07:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIOL7D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 07:59:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3F921B
        for <linux-integrity@vger.kernel.org>; Thu, 15 Sep 2022 04:59:00 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FBfh7t008600;
        Thu, 15 Sep 2022 11:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xwyFo391Jx3HlT8J911pbESxFykGFlhR+HQlhQu+byo=;
 b=OSX/lFFZsy4/J2lZlRno4cgCHdzAR12FwIrb+nw4woA6yjiMG9vEzH5BMV59Z8EfvgoC
 qpYAIiAfr1a7G/U35lrb+K80z6P6WHVoPLBzjs7mtBuBxUd6qnVxg/YGbscXFsjdBDt1
 JccsLZAM92boISBao3c7Sh7hRDM4EAES+hT6iuaAO00uqutsju7wy4Nrfxw53MCUUAEo
 MzWQOf19mUV8tblZl0fX3JpoJa6BL70O/RhyxKDiNrfO01dpC7he4rlIVLh/XwEPSidH
 hxCwXkA4wm5hE7yB1hBxQ082gyvP6GIEONi++EgILZQCw0Y3z6ZfW6hNHlNKltUKUHL3 9g== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm3d90gkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 11:58:54 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FBpwkX027423;
        Thu, 15 Sep 2022 11:58:53 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3jjydhb0x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 11:58:53 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FBwprC41878234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 11:58:51 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16DC213605E;
        Thu, 15 Sep 2022 11:58:52 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1053136059;
        Thu, 15 Sep 2022 11:58:51 +0000 (GMT)
Received: from sig-9-77-142-138.ibm.com (unknown [9.77.142.138])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 11:58:51 +0000 (GMT)
Message-ID: <4e9bfc7330e205d1b2a872c6b128eab62c66263e.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3 06/15] Add missing EVP_MD_CTX_free()
 call in calc_evm_hash()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 15 Sep 2022 07:58:51 -0400
In-Reply-To: <20220914145136.7xiziuvcsqtiyex3@altlinux.org>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
         <20220914022956.1359218-7-zohar@linux.ibm.com>
         <20220914145136.7xiziuvcsqtiyex3@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TTTWFSMvTfBYSK1OBtLmSLmdZkouwI0u
X-Proofpoint-GUID: TTTWFSMvTfBYSK1OBtLmSLmdZkouwI0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=953 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

Thank you for this and the other reviews.  They'll be addressed in the
next version.

On Wed, 2022-09-14 at 17:51 +0300, Vitaly Chikunov wrote:
> > @@ -350,12 +356,11 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
> >  #if OPENSSL_VERSION_NUMBER < 0x10100000
> >       EVP_MD_CTX ctx;
> >       pctx = &ctx;
> > -#else
> > -     pctx = EVP_MD_CTX_new();
> >  #endif
> >  
> >       if (lstat(file, &st)) {
> >               log_err("Failed to stat: %s\n", file);
> > +             errno = 0;
> 
> Why it clears errno (here and below)?
> 
> errno(3) says "The value of errno is never set to zero by any system
> call or library function."

evmctl, itself, is not a system call or a library function.  Is this a
generic statement or here in particular as to how evmctl should handle
failed system calls?   Another example is reading the keyfile.  The
existence of which is not required.

thanks,

Mimi


