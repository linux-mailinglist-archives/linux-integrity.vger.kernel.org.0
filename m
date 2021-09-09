Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969CB405CCC
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhIISVe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 14:21:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237172AbhIISVd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 14:21:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189I33tg122533;
        Thu, 9 Sep 2021 14:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=erHfOdx08EWozN6BnhI7jsS+xKpAJcbAaIAogHs1CRw=;
 b=TkuWp4tqSnI+l0GgQEAjPXwyptpn8gz6OFnovf7gUio7D2YrYd3c8SvPQtR12t48mjt/
 arT5M0nAku1J4d+mTnRuFCWaQGOSlUC2rQ3HZfGjntpq+3uXKc/2hvI2k2YdXvBcXUvA
 7CzfgKK7Sbvz9+Nx2DvJUWscIcC+cAWlhfhsT2nWT5egvjE1flsDlrhYNv52FxsyLM6R
 4o0DBMPf3Yxng1MhDQJZJvk48ZGZvy5XlU4l5zzcafLKN46qZ/jGIwW4jel0YocCz4Yv
 xZwB8Id+c8z5b+qsolnMs7xvU19t/b68iEp1CKBdd4dwBfIMWowxYuq8LX/ZsVK/0Wxp 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ayq5fghq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 14:20:04 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 189IK4I4008389;
        Thu, 9 Sep 2021 14:20:04 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ayq5fghp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 14:20:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189IHUXj018851;
        Thu, 9 Sep 2021 18:20:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3ayfv2x9fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 18:20:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189IJxBN43516240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 18:19:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 938F5AE04D;
        Thu,  9 Sep 2021 18:19:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EB77AE051;
        Thu,  9 Sep 2021 18:19:54 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Sep 2021 18:19:54 +0000 (GMT)
Message-ID: <7552eec6c65807fe75127215e7996b76dd851653.camel@linux.ibm.com>
Subject: Re: [PATCH v5 07/12] KEYS: Introduce link restriction to include
 builtin, secondary and machine keys
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
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Date:   Thu, 09 Sep 2021 14:19:53 -0400
In-Reply-To: <6BD395AE-2549-4E33-8F4F-34B3BDB0649A@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-8-eric.snowberg@oracle.com>
         <b8ba9facf525c60760b49da6cea50d701ad5613d.camel@linux.ibm.com>
         <6BD395AE-2549-4E33-8F4F-34B3BDB0649A@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HVYllI259MEnBR5GmbORb38D8Sg3tAPG
X-Proofpoint-ORIG-GUID: wj5YIQyOMzka2yoZyQh9bboKXSFnRQPV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_06:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090110
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-09 at 12:03 -0600, Eric Snowberg wrote:
> > On Sep 9, 2021, at 11:26 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > Hi Eric,
> > 
> > The subject line above is too long.   According to
> > Documentation/process/submitting-patches.rst the "the ``summary`` must
> > be no more than 70-75 characters".
> > 
> > On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
> >> Introduce a new link restriction that includes the trusted builtin,
> >> secondary and machine keys. The restriction is based on the key to be added
> >> being vouched for by a key in any of these three keyrings.
> >> 
> >> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >> ---
> >> v3: Initial version
> >> v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
> >> v5: Rename to machine keyring
> >> ---
> >> certs/system_keyring.c        | 23 +++++++++++++++++++++++
> >> include/keys/system_keyring.h |  6 ++++++
> >> 2 files changed, 29 insertions(+)
> >> 
> >> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> >> index 08ea542c8096..955bd57815f4 100644
> >> --- a/certs/system_keyring.c
> >> +++ b/certs/system_keyring.c
> >> @@ -99,6 +99,29 @@ void __init set_machine_trusted_keys(struct key *keyring)
> >> {
> >> 	machine_trusted_keys = keyring;
> >> }
> >> +
> >> +/**
> >> + * restrict_link_by_builtin_secondary_and_ca_trusted
> > 
> > Sorry for the patch churn.  With the keyring name change to ".machine",
> > the restriction name should also reflect this change.
> 
> Yes, I can change that. Should it be renamed to 
> restrict_link_by_builtin_secondary_and_machine_trusted? That seems a little
> long though.  Thanks.

The existing name is long too.  Not sure it makes much of a difference,
but dropping "and" and/or "trusted" might help.

Mimi

