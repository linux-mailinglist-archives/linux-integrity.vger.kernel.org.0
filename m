Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E04D669D
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Mar 2022 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiCKQo2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 11:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiCKQoY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 11:44:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399AD13C9FB;
        Fri, 11 Mar 2022 08:43:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA337B829A4;
        Fri, 11 Mar 2022 16:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA56C340E9;
        Fri, 11 Mar 2022 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647016998;
        bh=NGSf7wh7KErzRwh8777PMESJvkVovOKxuvOkNDjaDTM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oPBCbhaZnjBb0Fp1Dp9/TERj/Kk5cGuzqaKADCPRmqfhsPznyeja0naEESM5eQowk
         h0WfvX7lmehPrf8sX0CD0fEHMIE8ZQBm4TuqvksmQYm2XdC9I+80Zio04bvO5y0KCS
         nBDa/eYz+ia96/67PQ309QQSAsf+qcnNmHaoJKvVrZ6DCsRKyUvxdocXPi9N9B/3nr
         xGzAa1P7xtr9i5rNS8vOXDeRRntfIDlkBWp8uuxSra3yiXzgePM0rmtsfv7ZQZcqWw
         tWgTksczy6qKGi+EpNKSi1L4d5+iV1UWMaiMVXUGUJZ7gfBdc8yahhoqOZiMd3kbXp
         Iypz4HgBTCODQ==
Message-ID: <f78d11fefd13bd17748e36621acee9c2f27a77f6.camel@kernel.org>
Subject: Re: [PATCH v11 0/4] integrity: support including firmware
 ".platform" keys at build time
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nageswara Sastry <rnsastry@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 11 Mar 2022 18:42:33 +0200
In-Reply-To: <4afae87c-2986-6b0e-07be-954dd4937afd@linux.ibm.com>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
         <4afae87c-2986-6b0e-07be-954dd4937afd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-03-11 at 10:11 +0530, Nageswara Sastry wrote:
>=20
>=20
> On 11/03/22 3:14 am, Nayna Jain wrote:
> > Some firmware support secure boot by embedding static keys to verify th=
e
> > Linux kernel during boot. However, these firmware do not expose an
> > interface for the kernel to load firmware keys onto the ".platform"
> > keyring, preventing the kernel from verifying the kexec kernel image
> > signature.
> >=20
> > This patchset exports load_certificate_list() and defines a new functio=
n
> > load_builtin_platform_cert() to load compiled in certificates onto the
> > ".platform" keyring.
> >=20
> > Changelog:
> > v11:
> > * Added a new patch to conditionally build extract-cert if
> > PLATFORM_KEYRING is enabled.
> >=20
>=20
> Tested the following four patches with and with out setting=20
> CONFIG_INTEGRITY_PLATFORM_KEYS
>=20
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

OK, I added it:

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

BR, Jarkko
