Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34A46480FA
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Dec 2022 11:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLIKbb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Dec 2022 05:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLIKba (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Dec 2022 05:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29E35C768
        for <linux-integrity@vger.kernel.org>; Fri,  9 Dec 2022 02:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670581836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mDqG2zuj1T8QltKNt6BqePbyvY/3U9dLEeoyj7ugVdo=;
        b=FXKjeACKKZnE0Pf7NDAvKvmSHyDVdwZPg/YAo9/ntCgyTwaLbBc8rast3aUiJJ+fnhdht2
        L14baGBtM01WhtVJUAaWmY0rfYN8RIOjiIvXqWuCvnWfMTfIuk/hqKHPr3HL/AMcBdxDTi
        IsUGA6AZRGsqFvH+rcxwza+nIoXcUiE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-wvg1LrtOOWux2bScvmDz9g-1; Fri, 09 Dec 2022 05:30:34 -0500
X-MC-Unique: wvg1LrtOOWux2bScvmDz9g-1
Received: by mail-pf1-f199.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso3039142pfi.7
        for <linux-integrity@vger.kernel.org>; Fri, 09 Dec 2022 02:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDqG2zuj1T8QltKNt6BqePbyvY/3U9dLEeoyj7ugVdo=;
        b=c4HV816gusxCIK2rVk3/z7HylD4Y/JF+j6qky6zBHoXYkXhHkBuUf8/xAp4JXyRouo
         kMponZTVFxTf8S9rc4w/erEFeUZrXd5SoXPnf+2R12EdXMTVK9euZuyuWqMtJJ5l8xGh
         ZJyq5U/bOt7UeTe9LSuBH6yiVPTWDXwsbL8uNW1a6Z4orRbIm/snlVExYN5zdYi4YEQt
         UDN3lHsvn3g3cVhE16TdM/wG8w6wMWMJgek/h9lxm/y2LWHIWHfmJ6F/ZhE2eTe8E8Xg
         8mBhn5mZzhqm8VHb3vJdg1uujOKUBtvWe/1bf8XbnwmPX4Pd+vhfEVlkBhbVrXmiHZ2K
         x+TA==
X-Gm-Message-State: ANoB5pmc8QN9ovciBCm61MqrMsmHVqEWL8vrRU+smHvEMlfEHAzNeZj0
        O2nCmG/O+T6L1SAgP15lU7gHwCtp1MTWnsGEnYz4ilKbThwz8HNkX6ls876k+mOAtlW7xveylYr
        2TupgUVs2y85cYHoLUIWtbuE6gpju
X-Received: by 2002:a05:6a00:7ca:b0:577:3944:aa78 with SMTP id n10-20020a056a0007ca00b005773944aa78mr4462686pfu.0.1670581833522;
        Fri, 09 Dec 2022 02:30:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7BLHzoAtcaW4DEwUxYm+9XaWCGq4OLMeorfPtYBpS2cFrUmo909d1j+BcuOjAQe8kg1n7D5Q==
X-Received: by 2002:a05:6a00:7ca:b0:577:3944:aa78 with SMTP id n10-20020a056a0007ca00b005773944aa78mr4462655pfu.0.1670581833178;
        Fri, 09 Dec 2022 02:30:33 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y19-20020aa79433000000b005743b5ebd7csm997592pfo.92.2022.12.09.02.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 02:30:32 -0800 (PST)
Date:   Fri, 9 Dec 2022 18:26:12 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        pvorel@suse.cz, noodles@fb.com, tiwai@suse.de, bp@suse.de,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Add CA enforcement keyring restrictions
Message-ID: <20221209102612.wa3oftpqupzplx6h@Rk>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221207171238.2945307-1-eric.snowberg@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

Thanks for your work! The patch set looks good to me except for the
requirement of an intermediate CA certificate should be vouched for by a
root CA certificate before it can vouch for other certificates. What if
users only want to enroll an intermediate CA certificate into the MOK?
If this requirement could be dropped, the code could be simplified and
some issues could be resolved automatically,

1. "[PATCH v2 03/10] KEYS: X.509: Parse Basic Constraints for CA" added
    a root_ca filed to a certificate to indicate the subject of the
    certificate is a CA. The name root_ca implies it's also a root CA. But
    according to [1], both an intermediate and root CA will have
    root_ca=True. For example, the intermediate certificate of
    https://www.kernel.org/ has "Certificate Authority=Yes" in the basic
    constraints. Btw, a root CA certificate by definition is self-signed,
    so the following code in "[PATCH v2 05/10] KEYS: Introduce a CA
    endorsed flag" looks a bit strange to me,
     if (cert->kcs_set && cert->self_signed && cert->root_ca)
         prep->payload_flags |= KEY_ALLOC_PECA;

2. Since an intermediate CA certificate also has root_ca=True,
    "[PATCH v2 07/10] KEYS: X.509: Flag Intermediate CA certs as
    endorsed" won't work as intended i.e. this following else branch
    will never be reached,
    else if (!cert->self_signed && !cert->root_ca)
            prep->payload_flags |= KEY_MAYBE_PECA;

3. I see nowhere public_key->key_is_ca is set to true for an intermediate
    CA certificate after it gains the KEY_ALLOC_PECA flag. So it will fail
    restrict_link_by_ca even if the KEY_MAYBE_PECA flag is added.

[1] https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.9

On Wed, Dec 07, 2022 at 12:12:28PM -0500, Eric Snowberg wrote:
>Prior to the introduction of the machine keyring, most distros simply
>allowed all keys contained within the platform keyring to be used
>for both kernel and module verification.  This was done by an out of
>tree patch.  Some distros took it even further and loaded all these keys
>into the secondary trusted keyring.  This also allowed the system owner
>to add their own key for IMA usage.
>
>Each distro contains similar documentation on how to sign kernel modules
>and enroll the key into the MOK.  The process is fairly straightforward.
>With the introduction of the machine keyring, the process remains
>basically the same, without the need for any out of tree patches.
>
>The machine keyring allowed distros to eliminate the out of tree patches
>for kernel module signing.  However, it falls short in allowing the end
>user to add their own keys for IMA. Currently the machine keyring can not
>be used as another trust anchor for adding keys to the ima keyring, since
>CA enforcement does not currently exist.  This would expand the current
>integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
>Kconfig states that keys may be added to the ima keyrings if the key is
>validly signed by a CA cert in the system built-in or secondary trusted
>keyring.  Currently there is not code that enforces the "validly signed"
>CA cert. Any key in the builtin or secondary keyring can be used.  Also,
>the definition of "validly signed" has never been stated, leaving this up
>to multiple interpretations.
>
>To allow IMA to be enabled with the machine keyring, this series introduces
>enforcement of key usage in the certificate. This series also defines a
>"validly signed" CA cert and applies the same definition across all
>kernel keyrings.
>
>The machine keyring shares  similarities with both the builtin and
>secondary keyrings.  Similar to the builtin, no keys may be added to the
>machine keyring following boot. The secondary keyring allows user
>provided keys to be added following boot; however, a previously enrolled
>kernel key must vouch for the key before it may be included. The system
>owner may include their own keys into the machine keyring prior to boot.
>If the end-user is not the system owner, they may not add their own keys
>to the machine keyring.
>
>The machine keyring is only populated when Secure Boot is enabled.  A
>system owner has the ability to control the entire Secure Boot keychain
>(PK, KEK, DB, and DBX).  The system owner can also turn Secure Boot off.
>With this control, they may use insert-sys-cert to include their own key
>and re-sign their kernel and have it boot.  The system owner also has
>control to include or exclude MOK keys. This series does not try to
>interpret how a system owner has configured their machine.  If the system
>owner has taken the steps to add their own MOK keys, they will be
>included in the machine keyring and used for verification, exactly
>the same way as keys contained in the builtin and secondary keyrings.
>Since the system owner has the ability to add keys before booting to
>either the machine or builtin keyrings, it is viewed as inconsequential
>if the key originated from one or the other.
>
>This series introduces two different ways to configure the machine keyring.
>By default, nothing changes and all MOK keys are loaded into it.  Whenever
>a "validly signed" key is found within the machine, builtin, or
>secondary, a flag indicating this is stored in the public key struct.
>The other option is if the new Kconfig INTEGRITY_CA_MACHINE_KEYRING is
>enabled, only "validly signed" CA certs will be loaded into the machine
>keyring. All remaining MOK keys will be loaded into the platform keyring.
>
>A "validly signed" CA cert shall be defined as any X509 certificate that
>is self signed, contains the keyCertSign key usage and has the CA bit
>set to true.
>
>With this series applied, "validly signed" CA enforcement is in place
>whenever IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled.
>Meaning, before any key can be included into the ima keyring, it must be
>vouched for by a "validly signed" CA key contained within the builtin,
>secondary, or machine keyrings.
>
>IMA allows userspace applications to be signed. The enduser may sign
>their own application, however they may also want to use an application
>provided by a 3rd party.  The entity building the kernel, may not be the
>same entity building the userspace program.  The system owner may also
>be a third entity.  If the system owner trusts the entity building the
>userspace program, they will include their public key within the MOK.
>This key would be used to sign the key added to the ima keyring. Not all
>3rd party userspace providers have the capability to properly manage a
>root CA.  Some may outsource to a different code signing provider.  Many
>code signing providers use Intermediate CA certificates. Therefore, this
>series also includes support for Intermediate CA certificates.  If a
>"validly signed" CA can vouch for an Intermediate CA, and it contains
>the keyCertSign key usage, it will also be flagged as being a "validly
>signed" CA. The Intermediate CA certificates could be loaded into the
>secondary keyring following boot. Afterwards, CA enforcement is
>maintained for any key added to the ima keyring.
>
>This series could be broken up into 3 different parts.  The first two
>patches could be taken now.  They solve current issues that will be
>triggered by the build robots.  Patches 3-8 add CA enforcement for the
>ima keyring.  Patches 9-10 restrict the machine keyring to only load CA
>certs into it.  Patches 9-10 require all the previous patches since
>Intermediate CA enforcement is required.
>
>Eric Snowberg (10):
>  KEYS: Create static version of public_key_verify_signature
>  KEYS: Add missing function documentation
>  KEYS: X.509: Parse Basic Constraints for CA
>  KEYS: X.509: Parse Key Usage
>  KEYS: Introduce a CA endorsed flag
>  KEYS: Introduce keyring restriction that validates ca trust
>  KEYS: X.509: Flag Intermediate CA certs as endorsed
>  integrity: Use root of trust signature restriction
>  KEYS: CA link restriction
>  integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
>
> certs/system_keyring.c                    | 30 ++++++++-
> crypto/asymmetric_keys/restrict.c         | 81 +++++++++++++++++++++++
> crypto/asymmetric_keys/x509_cert_parser.c | 31 +++++++++
> crypto/asymmetric_keys/x509_parser.h      |  2 +
> crypto/asymmetric_keys/x509_public_key.c  | 16 +++++
> include/crypto/public_key.h               | 30 +++++++++
> include/keys/system_keyring.h             | 12 +++-
> include/linux/ima.h                       | 11 +++
> include/linux/key-type.h                  |  3 +
> include/linux/key.h                       |  2 +
> security/integrity/Kconfig                | 11 ++-
> security/integrity/digsig.c               | 12 ++--
> security/integrity/ima/Kconfig            |  6 +-
> security/keys/key.c                       | 13 ++++
> 14 files changed, 249 insertions(+), 11 deletions(-)
>
>
>base-commit: 76dcd734eca23168cb008912c0f69ff408905235
>-- 
>2.27.0
>

-- 
Best regards,
Coiby

