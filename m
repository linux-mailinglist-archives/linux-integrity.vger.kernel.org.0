Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0571F463A11
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 16:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhK3PeV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 10:34:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229769AbhK3PeU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 10:34:20 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFQE9v005941;
        Tue, 30 Nov 2021 15:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=lRJ9EeRkehNcBeN0Slv1bMFVDNn8zq/kDiLTfuorS78=;
 b=djlV+m4uyuRwJxKWjfgbwasZlTtheaI/iQD1iWPDifkwk6+2q57+Gui7hqzlMkrJdUso
 rohgduHkETF0ss9YUMvAG0gVXd6e9i/HTyEbsbSfhpaxmQTCzUrfvS5x8GHkXyTWfWU9
 l9vVAJ5yHGCCEhZs4r8KjplCmNBt+67jxPvgAxeqBWth2Kt3BI2/ItDvOgOZl5ptvRjB
 yDj+D+9c0dVjtVX6EZZoJYHu5g4dCDBlN5LiXNMWTHDiKW52u2EaBlPqVZ7R+FCwmORf
 vka7rL1E4is9bf/y6hyVgq6RekVhn5OCBK1ZkGh0bOp6Z2RLnygk2kroWzDTUZ3ozrji jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cnpg7099n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 15:28:38 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFQSLI007382;
        Tue, 30 Nov 2021 15:28:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cnpg7098n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 15:28:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFD54u004410;
        Tue, 30 Nov 2021 15:28:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ckcacg7wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 15:28:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUFSTWQ19136886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 15:28:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05C03A404D;
        Tue, 30 Nov 2021 15:28:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4C52A4059;
        Tue, 30 Nov 2021 15:28:27 +0000 (GMT)
Received: from osiris (unknown [9.145.157.87])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Nov 2021 15:28:27 +0000 (GMT)
Date:   Tue, 30 Nov 2021 16:28:26 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     keyrings@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] KEXEC_SIG with appended signature
Message-ID: <YaZDGjKSaH2YKl/h@osiris>
References: <cover.1637862358.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rSCYo3RBvp-zpEg4RRrySvGTJx2g36_q
X-Proofpoint-GUID: -IO6R0uBLYVSlOsUgVLBc1VitLs8tbzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=829
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 25, 2021 at 07:02:38PM +0100, Michal Suchanek wrote:
> Hello,
> 
> This is resend of the KEXEC_SIG patchset.
> 
> The first patch is new because it'a a cleanup that does not require any
> change to the module verification code.
> 
> The second patch is the only one that is intended to change any
> functionality.
> 
> The rest only deduplicates code but I did not receive any review on that
> part so I don't know if it's desirable as implemented.
> 
> The first two patches can be applied separately without the rest.
> 
> Thanks
> 
> Michal
> 
> Michal Suchanek (6):
>   s390/kexec_file: Don't opencode appended signature check.
>   powerpc/kexec_file: Add KEXEC_SIG support.
>   kexec_file: Don't opencode appended signature verification.
>   module: strip the signature marker in the verification function.
>   module: Use key_being_used_for for log messages in
>     verify_appended_signature
>   module: Move duplicate mod_check_sig users code to mod_parse_sig
> 
>  arch/powerpc/Kconfig                     | 11 +++++
>  arch/powerpc/kexec/elf_64.c              | 14 ++++++
>  arch/s390/kernel/machine_kexec_file.c    | 42 ++----------------
>  crypto/asymmetric_keys/asymmetric_type.c |  1 +
>  include/linux/module_signature.h         |  1 +
>  include/linux/verification.h             |  4 ++
>  kernel/module-internal.h                 |  2 -
>  kernel/module.c                          | 12 +++--
>  kernel/module_signature.c                | 56 +++++++++++++++++++++++-
>  kernel/module_signing.c                  | 33 +++++++-------
>  security/integrity/ima/ima_modsig.c      | 22 ++--------
>  11 files changed, 113 insertions(+), 85 deletions(-)

For all patches which touch s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
