Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AAF5BADE2
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Sep 2022 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIPNNp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Sep 2022 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiIPNNb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Sep 2022 09:13:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258779F1B5
        for <linux-integrity@vger.kernel.org>; Fri, 16 Sep 2022 06:13:31 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GD30Zm030696;
        Fri, 16 Sep 2022 13:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=chz6SPqa/w+nVt64qvV6oXhrNAM0JzNEm3PYPmyA8RQ=;
 b=PGCD9mcRz0nJpsC/qfM2lL5FBwm5grRVPVTReA5sMdWT2+hCQvxjfAWZ27F604YMtNvf
 Szc/aX/BNla3SUiayAyEbOtuRfhySkOq2oIIwt+fVJyzf8naR7nRbdt2W8jMwqc/nCqS
 7a+bAayZKWyyWnL91SI0AbKh841APCJ7z4tvgo/AE4SYeQR1icpueO1H2Jsf7gQq8kok
 GD5dd/tFANHugSMHtcjKX+uocyn/f1ETFDHllGeZCV53qtPsXlakeIVnj62VUujIVexY
 cNgXLvowA6HMMaLV15pLJLv4G9ZEjx/t6yRD2jWslFOAqrmUcRhbCxdyncwooffstDMz bg== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmsksrwy1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:13:24 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GD6Mfu015754;
        Fri, 16 Sep 2022 13:07:52 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3jm91w4ydt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:07:52 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GD7pBs6488664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 13:07:51 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A97CA28058;
        Fri, 16 Sep 2022 13:07:51 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75CA92805A;
        Fri, 16 Sep 2022 13:07:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.93.89])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Sep 2022 13:07:51 +0000 (GMT)
Message-ID: <17a92cfa3e8af21bb057abc374ff250c5c8b942b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3 06/15] Add missing EVP_MD_CTX_free()
 call in calc_evm_hash()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 16 Sep 2022 09:07:51 -0400
In-Reply-To: <20220915153659.dtykhzitxdrlpasq@altlinux.org>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
         <20220914022956.1359218-7-zohar@linux.ibm.com>
         <20220914145136.7xiziuvcsqtiyex3@altlinux.org>
         <4e9bfc7330e205d1b2a872c6b128eab62c66263e.camel@linux.ibm.com>
         <20220915153659.dtykhzitxdrlpasq@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1y2BsWFZxEb-4DwA_LPvIddEIQ90H1s9
X-Proofpoint-GUID: 1y2BsWFZxEb-4DwA_LPvIddEIQ90H1s9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-09-15 at 18:36 +0300, Vitaly Chikunov wrote:
> On Thu, Sep 15, 2022 at 07:58:51AM -0400, Mimi Zohar wrote:
> > Hi Vitaly,
> > 
> > Thank you for this and the other reviews.  They'll be addressed in the
> > next version.
> > 
> > On Wed, 2022-09-14 at 17:51 +0300, Vitaly Chikunov wrote:
> > > > @@ -350,12 +356,11 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
> > > >  #if OPENSSL_VERSION_NUMBER < 0x10100000
> > > >       EVP_MD_CTX ctx;
> > > >       pctx = &ctx;
> > > > -#else
> > > > -     pctx = EVP_MD_CTX_new();
> > > >  #endif
> > > >  
> > > >       if (lstat(file, &st)) {
> > > >               log_err("Failed to stat: %s\n", file);
> > > > +             errno = 0;
> > > 
> > > Why it clears errno (here and below)?
> > > 
> > > errno(3) says "The value of errno is never set to zero by any system
> > > call or library function."
> > 
> > evmctl, itself, is not a system call or a library function. 
> 
> Ah, I wasn't attentive this is only evmctl. [But there's similar commit
> acb19d1 ("Reset 'errno' after failure to open or access a file")
> changing libimaevm.c which is wrong.]
> 
> Perhaps it should be noted in commit message that errno is cleared
> because it's error message is already printed to avoid double printing
> at exit of cmd handler.
> 
> > Is this a
> > generic statement or here in particular as to how evmctl should handle
> > failed system calls?   Another example is reading the keyfile.  The
> > existence of which is not required.
> 
>           log_err("Failed to stat: %s\n", file);
> 
> This does not even output errno code, but it could be very informative
> to user. I think it's better to print (at least errno or) strerror for
> users there (and on other syscall errors log_err instances.
> 
> Maybe to add special log function (like log_strerr) just for evmctl
> which will print (non "\n"-terminated) error message (similar to
> warn(3)) with strerror output appended (and commented in the code why
> it) clears errno (so that later handlers do not print it again).
> 
> ps. About libimaevm.c--I think errno should not be touched there as this
> breaks what coders expect from libraries. If this affects exit of evmctl
> then it should be handled in evmctl, not in the library. (Of course it's
> better to add strerror(errno) to log_err there too, but not by the
> proposed above function.)

Thank you for the suggestions.  log_errno() is already defined.  Not
sure how I missed that.  So use log_errno() in libimaevm.c.  For
evmctl.c, define a wrapper named log_and_reset_errno(), with your
suggested patch description.

Since none of the changes in next-testing have been released, they can
still be fixed/squashed as needed.

thanks!

Mimi

