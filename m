Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08D53EACFB
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 00:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhHLWQB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 18:16:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhHLWQB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 18:16:01 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CM36Ep010165;
        Thu, 12 Aug 2021 18:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jXuuL9nDKscnOlsJ2pu3vSiBY2Z0d/NmgUpZWDTrCg8=;
 b=EVILxTi1Qgv34/KUO/x/uyR1haRgsX7tVVUixQZIlLlwTWUtfdROF2F0foCFJs+USjGA
 IYjXgxKqpaUD7ASmOsJmlL/HhSyvzWJFx9K3MlYqEBcrGYQh0BOwr6UTy77Ot0r22Bef
 xHwmfK6ywQj3kX9AZP6kvJl3ai9r39zz6gvFulP040ZphEBCV/PRrYxV7qvtgy5Zx6Hr
 RiNjBfzPLZwRv9SCMl/MxjBdcZWJZk5xnXHRKBb3L/kTg5IbBsNLWYKJhglYjUXMQ+0T
 BdlY6YE5IUPZrCmQk4Rmx7MxKyNGAQnrE3/vTj5SHEQ3Sg+dX5CethzAafTI33dkTxhO Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3acstp7nua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 18:15:02 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17CM387O010460;
        Thu, 12 Aug 2021 18:15:01 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3acstp7ntm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 18:15:01 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CLvpXx017315;
        Thu, 12 Aug 2021 22:14:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3acfpgaf96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 22:14:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CMBdNt53281194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:11:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83B7C4C04A;
        Thu, 12 Aug 2021 22:14:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA1734C040;
        Thu, 12 Aug 2021 22:14:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.41.31])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 22:14:50 +0000 (GMT)
Message-ID: <0b178f91b33d1aed7ab90669ef059185e3b38bcc.camel@linux.ibm.com>
Subject: Re: [PATCH v3 10/14] KEYS: change link restriction for secondary to
 also trust mok
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
Date:   Thu, 12 Aug 2021 18:14:49 -0400
In-Reply-To: <F792F96B-C482-4F28-A984-A6B5F49C3A56@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
         <20210812021855.3083178-11-eric.snowberg@oracle.com>
         <58e6e03b69b8fadfb854669086020c633837be88.camel@linux.ibm.com>
         <F792F96B-C482-4F28-A984-A6B5F49C3A56@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zg3D1jlsg1pYQ4INzvBV7Z4w_zaEJ7fr
X-Proofpoint-ORIG-GUID: WTtHv8Sf9Y_71YKb6-iggKyArtRIZyfj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_06:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120140
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-12 at 16:10 -0600, Eric Snowberg wrote:
> > On Aug 12, 2021, at 1:46 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Wed, 2021-08-11 at 22:18 -0400, Eric Snowberg wrote:
> >> With the introduction of the mok keyring, the end-user may choose to
> >> trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
> >> trust them, the .mok keyring will contain these keys.  If not, the mok
> >> keyring will always be empty.  Update the restriction check to allow the
> >> secondary trusted keyring to also trust mok keys.
> >> 
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >> ---
> >> v3: Initial version
> >> ---
> >> certs/system_keyring.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> >> index cb773e09ea67..8cc19a1ff051 100644
> >> --- a/certs/system_keyring.c
> >> +++ b/certs/system_keyring.c
> >> @@ -110,7 +110,7 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
> >> 	if (!restriction)
> >> 		panic("Can't allocate secondary trusted keyring restriction\n");
> >> 
> >> -	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
> >> +	restriction->check = restrict_link_by_builtin_secondary_and_ca_trusted;
> >> 
> >> 	return restriction;
> >> }
> > 
> > Not everyone needs to build a generic kernel, like the distros.  As
> > previously discussed, not everyone is willing to trust the new MOK
> > keyring nor the UEFI variable for enabling it.  For those environments,
> > they should be able to totally disable the MOK keyring.
> > 
> > Please define a Kconfig similar to "CONFIG_SECONDARY_TRUSTED_KEYRING"
> > for MOK.  The "restriction" would be based on the new Kconfig being
> > enabled.
> 
> Yes, I can add that.  Currently there is a Kconfig to enable the secondary 
> and another for IMA to trust the secondary.  Would you like to see two new 
> Kconfig options added?  One that allows the secondary to use the mok as a new 
> trust  source and another for IMA to trust the mok keyring.  Or a single Kconfig 
> that handles both?  Thanks.

A single Kconfig option for enabling the new keyring should be fine.

thanks,

Mimi

