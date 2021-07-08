Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8EF3C19D5
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 21:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhGHTef (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 15:34:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229497AbhGHTee (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 15:34:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168J2tTl170332;
        Thu, 8 Jul 2021 15:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZzzOZykbO5QMdxGLhuT6hx8FDb0c0UjkV/9s7AfHQLQ=;
 b=Sw+aHGRn21aswTCdI20LxnX2frLNJicCucWHY/Jbzm30Q0e27vXltma0WYEsaUkM2/pZ
 yh4A50daDGe7uQaZp57VN4yqR7e1WWBVa1ZRYFWrpFxmXXP4n12armrSQ/abNTzylfI0
 +gY6A22a58Fws0i1ylGERGXsxDxD+JnvtypALj7USBy/dqnbPQzw5tGwWj5c5A98SrWF
 39yv+VHNdf5b1ej/AjbqCqUOrkXVGXm5HGlwO/PQHFAuvmrgAuotUysdgAUjyRWMQ8om
 ULcJ/iY87fZDqHXCCUrIKS+w4X9csH7K7RxPkL8ohnFTOoDmSI+iBaKZvsjilcXnb0Z3 xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39p1y5m90p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 15:31:21 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 168J38F3170861;
        Thu, 8 Jul 2021 15:31:21 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39p1y5m901-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 15:31:20 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168JEObG025826;
        Thu, 8 Jul 2021 19:31:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 39jf5habhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 19:31:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168JVGQZ28377532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 19:31:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB60FAE045;
        Thu,  8 Jul 2021 19:31:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5081BAE04D;
        Thu,  8 Jul 2021 19:31:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.121.73])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 19:31:11 +0000 (GMT)
Message-ID: <490941a5197bf4bcf0d6f95610085ee4d46ed9bb.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 08 Jul 2021 15:31:10 -0400
In-Reply-To: <21EFCB58-2D89-4D30-8DA2-B952A7E1B1BD@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
         <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
         <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
         <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
         <D34A6328-91CA-4E1E-845C-FAC9B424819B@oracle.com>
         <c0cf7f883a9252c17427f1f992e4973e78481304.camel@linux.ibm.com>
         <21EFCB58-2D89-4D30-8DA2-B952A7E1B1BD@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aggJvet0yOt-ImSnGQ0anKTGvo1Pu3_V
X-Proofpoint-GUID: nzOHRzEqfJNWiGRgDl2PnNQs2Gmz1T0Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_11:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Thu, 2021-07-08 at 11:59 -0600, Eric Snowberg wrote:
> 
> >  Asumming a
> > function similar to "restrict_link_by_builtin_and_secondary_trusted" is
> > defined to include the MOK keyring, the CA keys in the MOK db would be
> > loaded onto the MOK keyring, the other keys that meet the secondary
> > keyring restriction would be loaded directly onto the secondary
> > keyring[1], and as you currently have, the remaining keys onto the
> > platform keyring.
> > 
> > This eliminates the exemption needed for loading keys onto the
> > secondary keyring.  The MOK keyring, containing just CA keys, becomes a
> > new trust source.
> 
> I just want to make sure I understand. If we kept the .mok keyring around, 
> we would store it into the system_keyring code, just like the platform 
> keyring is stored.  This would allow the move exemption code to be removed.
> If the mok keyring is a new trust source, whenever the secondary keyring 
> is referenced in verify_ code, the mok keyring will be checked too.  If 
> I have this right, let me know and I’ll work on a v2.  Thanks.

All the firmware keys are loaded onto the "platform" keyring, without
any restriction.  Your reference point should be the "builtin" and
"secondary" keyrings, not the "platform" keyring.

Changes:
- defining a new keyring restriction which only allows CA keys to be
loaded onto the MOK keyring.
- defining a new keyring restriction something along the lines of
"restrict_link_by_builtin_mok_and_secondary_trusted()".

In the case of "restrict_link_by_builtin_and_secondary_trusted()", it's
based on a build time option.  In the case of MOK, it might be both a
build time and runtime firmware variable option.  There are quite a few
permutations that will somehow need to be addressed:  secondary keyring
not defined, but MOK keyring defined, and the reverse.

Once all the CA keys in the MOK db are loaded onto the MOK keyring,
there will be no need for moving keys to the secondary keyring.  The
secondary keyring restriction will just work.  The main question is
whether there will need to be two passes.   One pass to first load all
the CA keys onto the MOK keyring.  A second pass to load the keys onto
the secondary keyring, based on the keyring restriction, and the
remaining ones onto the "platform" keyring to avoid the regression.

[Once the CA keys are loaded onto the MOK keyring, userspace will be
able to load certificates, signed by a key on the MOK keyring, onto the
secondary keyring.]

thanks,

Mimi

