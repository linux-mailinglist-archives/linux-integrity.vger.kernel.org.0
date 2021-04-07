Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCC3566F4
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 10:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbhDGIiP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 04:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241558AbhDGIiO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 04:38:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E50DB61029;
        Wed,  7 Apr 2021 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617784685;
        bh=pBXamQCtE+Jl3vwOnvZCx6CDYoIuAGECFVC8QyzvQGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEgeWQrJ6Lc5rkyGieZ2nfbVOm/pUQpwmCfS6jgg0wv60gQysMU9tpXLpk3eBGmUC
         J411RRewAATVvRLI3Nf6ncVGbeWM0VyHupvpj/sS02fkCS1xflEXcWM6a+bZ03JdCB
         5TW469vFnIGjljD4ZfmCCIOh3LOMP1+1HmWFeiFqpT5uxJzbwalNxLjZbvlSDlUXAU
         x+YOzXeB5FkOP5IlbHysGs2CQ699oU5Z+fwc5Uq9jiDto6CjpW0HbhdHdJQfr7uZyT
         kPMv69JwuxiX7tHyO2IT/B8VM7mnl0QmVK8+pV4IDTVBEqfh4dAlAwClF7B1IDidhW
         VyCyFkdS5cdcQ==
Date:   Wed, 7 Apr 2021 11:38:02 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hongbo Li <herbert.tencent@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, herberthbli@tencent.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 0/5] crypto: add rsa pss support for x509
Message-ID: <YG1vakmzanwPGsvU@kernel.org>
References: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 06, 2021 at 09:11:21PM +0800, Hongbo Li wrote:
> From: Hongbo Li <herberthbli@tencent.com>
> 
> This series of patches adds support for x509 cert signed by RSA
> with PSS encoding method. RSA PSS is described in rfc8017.

Please also briefly describe it here AND also provide link to the
RFC. In the way this currently is, it is too time consuming to
review the patch set.

/Jarkko

> 
> This series of patches adds support for x509 cert signed by RSA
> with PSS encoding method. RSA PSS is described in rfc8017.
> 
> Patch1 make x509 support rsa pss algo and parse hash parameter.
> 
> Patch2 add rsa pss template.
> 
> Patch3 add test vector for rsa pss.
> 
> Patch4 is the ecdsa ima patch borrowed from Stefan Berge's ecdsa
>        patch series, rsa-pss's ima patch is made on top of this patch.
> 
> Patch5 is the rsa-pss's ima patch.
> 
> Test by the following script, it tests different saltlen, hash, mgfhash.
> 
> keyctl newring test @u
> 
> while :; do
>     for modbits in 1024 2048 4096; do
> 	if [ $modbits -eq 1024 ]; then
> 	    saltlen=(-1 -2 0 20 32 48 64 94)
> 	elif [ $modbits -eq 2048 ]; then
> 	    saltlen=(-1 -2 0 20 32 48 64 222)
> 	else
> 	    saltlen=(-1 -2 0 20 32 48 64 478)
> 	fi
> 
> 	for slen in ${saltlen[@]}; do
> 	    for hash in sha1 sha224 sha256 sha384 sha512; do
> 		for mgfhash in sha1 sha224 sha256 sha384 sha512; do
> 		    certfile="cert.der"
> 		    echo slen $slen
> 		    openssl req \
> 			    -x509 \
> 			    -${hash} \
> 			    -newkey rsa:$modbits \
> 			    -keyout key.pem \
> 			    -days 365 \
> 			    -subj '/CN=test' \
> 			    -nodes \
> 			    -sigopt rsa_padding_mode:pss \
> 			    -sigopt rsa_mgf1_md:$mgfhash \
> 			    -sigopt rsa_pss_saltlen:${slen} \
> 			    -outform der \
> 			    -out ${certfile} 2>/dev/null
> 
> 		    exp=0
> 		    id=$(keyctl padd asymmetric testkey %keyring:test < "${certfile}")
> 		    rc=$?
> 		    if [ $rc -ne $exp ]; then
> 			case "$exp" in
> 			    0) echo "Error: Could not load rsa-pss certificate!";;
> 			esac
> 			echo "modbits $modbits sha: $hash mgfhash $mgfhash saltlen: $slen"
> 			exit 1
> 		    else
> 			case "$rc" in
> 			    0) echo "load cert: keyid: $id modbits $modbits hash: $hash mgfhash $mgfhash saltlen $slen"
> 			esac
> 		    fi
> 		done
> 	    done
> 	done
>     done
> done
> 
> Hongbo Li (5):
>   x509: add support for rsa-pss
>   crypto: support rsa-pss encoding
>   crypto: add rsa pss test vector
>   crypto: ecdsa ima support
>   ima: add support for rsa pss verification
> 
>  crypto/Makefile                           |   7 +-
>  crypto/asymmetric_keys/Makefile           |   7 +-
>  crypto/asymmetric_keys/public_key.c       |   5 ++
>  crypto/asymmetric_keys/x509_cert_parser.c |  71 ++++++++++++++++-
>  crypto/rsa.c                              |  14 ++--
>  crypto/rsa_helper.c                       | 127 ++++++++++++++++++++++++++++++
>  crypto/testmgr.c                          |   7 ++
>  crypto/testmgr.h                          |  87 ++++++++++++++++++++
>  include/crypto/internal/rsa.h             |  25 +++++-
>  include/keys/asymmetric-type.h            |   6 ++
>  include/linux/oid_registry.h              |   2 +
>  security/integrity/digsig_asymmetric.c    |  34 ++++----
>  12 files changed, 363 insertions(+), 29 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
