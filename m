Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0864A3C1CF4
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 03:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGIBOI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 21:14:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhGIBOG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 21:14:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16913lvR179385;
        Thu, 8 Jul 2021 21:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FI1qzW9vg11HTR0gAlwlHCY0vo4meaCwC4bF1sUyszc=;
 b=QX3q5U2wrRa+C87k+scNfpcRlsHOkg2p1NA7GtPj0rSkVkL/b1Zbw4mmGBK+LVzItuPd
 izMijkJWK+3UAAMGLpHj1PUXcdB00EZOVNBjPDDdt+KmL0XhBNZGpM5i+PdJSfZxdY14
 hpR6WG8oD7FLbYgOs/B4Zjic/JkEiAq7ZoZwGvoShjHA7cau8sPoM2bjgaZwJ2WsaSaF
 n1vtYQ1BB8KIvri+xM8dUh/le70HXj1FLP0lgsNdlMTInUBlg6jY+OFuPAd+Ox5qNOYK
 MtOdJnWOx+gcCtpzxQOTvg2ndWFrV/bugKfeXhEu0wLPD1yLD88ixNYlNbCOCD2+qc5D 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39n287x0cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 21:11:00 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16919xLj196388;
        Thu, 8 Jul 2021 21:10:59 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39n287x0ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 21:10:59 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1691Av0W032007;
        Fri, 9 Jul 2021 01:10:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 39jfh8h9ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 01:10:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1691AsJB31326546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jul 2021 01:10:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F4A642041;
        Fri,  9 Jul 2021 01:10:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C8C74203F;
        Fri,  9 Jul 2021 01:10:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jul 2021 01:10:48 +0000 (GMT)
Message-ID: <ef480c8f83780eea4ff8fdcd35c6208760b5e1d7.camel@linux.ibm.com>
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
Date:   Thu, 08 Jul 2021 21:10:47 -0400
In-Reply-To: <839EF700-7A2C-4282-AF97-768FAD1A9957@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
         <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
         <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
         <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
         <D34A6328-91CA-4E1E-845C-FAC9B424819B@oracle.com>
         <c0cf7f883a9252c17427f1f992e4973e78481304.camel@linux.ibm.com>
         <21EFCB58-2D89-4D30-8DA2-B952A7E1B1BD@oracle.com>
         <490941a5197bf4bcf0d6f95610085ee4d46ed9bb.camel@linux.ibm.com>
         <839EF700-7A2C-4282-AF97-768FAD1A9957@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FMn_hX5NZ_CCLtfcgqQvPGUn7SHHsF0z
X-Proofpoint-ORIG-GUID: CZDy5YSAnV3UvrlJeOGW1sSUTSKHEugt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_14:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090003
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-07-08 at 17:17 -0600, Eric Snowberg wrote:
> > Once all the CA keys in the MOK db are loaded onto the MOK keyring,
> 
> To avoid confusion with the new keyring name, would it be more appropriate 
> to change what we are calling the .mok keyring to the .trusted_platform 
> keyring instead? Or just leave it as .mok?

Definitely not ".trusted_platform" keyring, as it would be too
confusing with the existing "trusted" key type [1].  At least for now,
leave it as ".mok".

thanks,

Mimi

[1] Documentation/security/keys/trusted-encrypted.rst

