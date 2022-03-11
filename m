Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700A04D66A9
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Mar 2022 17:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350442AbiCKQrc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 11:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349228AbiCKQrc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 11:47:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A9A1D06DC;
        Fri, 11 Mar 2022 08:46:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEA87B827DC;
        Fri, 11 Mar 2022 16:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E111CC340F4;
        Fri, 11 Mar 2022 16:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647017185;
        bh=bBXv7+nMT5shE7uvBAchmZWADyUTQwK7d0FlvRLXM1M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Cf1b3Jr0nyVYOZPFsIbw83LwGUgzARjucwpiqIX+HDv6wxEbk40pb3CAPbcMqdyar
         ipRi730UbTpv60zfFUCjLGn96DrMev7qz+F/OTMMQ5u5qPauWuBU+S3LnGTLJy99X0
         uR8iQ6GB5unb/qeDguorI42XoF73JrFJv58cLyO6lZPscNhYLqOl109/1qPxaBgwm1
         o2qdsfuoAG/0ulu4aKm1fMgESTDGJRJx9P2g9OeYuj7XciOFTS9lPnkKdiS9w355PI
         pUBPvVcIILbrJgnaAMP2s56UR7bFZkPEzI89MWFGRCQy7+K73Y+DYuJrn7GC8yFTl0
         ylzCO4LVN0DHA==
Message-ID: <f8b1ea77afe8d6698b4a2122254ff8be310412b1.camel@kernel.org>
Subject: Re: [PATCH v8 5/5] certs: Allow root user to append signed hashes
 to the blacklist keyring
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Mar 2022 18:45:39 +0200
In-Reply-To: <d782d661-215a-89ec-43af-cbb747098ca4@digikod.net>
References: <20210712170313.884724-1-mic@digikod.net>
         <20210712170313.884724-6-mic@digikod.net> <YidDznCPSmFmfNwE@iki.fi>
         <995fc93b-531b-9840-1523-21ae2adbe4ba@digikod.net>
         <YidX3jqNJeFfr1G1@iki.fi>
         <218eb9dc-d9bd-0173-5343-f44b58545aef@digikod.net>
         <YijPdDULqQipqhjT@iki.fi>
         <ea866d6d-228e-1250-47d4-46519a1abd30@digikod.net>
         <Yik0C2t7G272YZ73@iki.fi>
         <d782d661-215a-89ec-43af-cbb747098ca4@digikod.net>
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

On Fri, 2022-03-11 at 17:36 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
>=20
> On 10/03/2022 00:11, Jarkko Sakkinen wrote:
> > On Wed, Mar 09, 2022 at 07:36:50PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > >=20
> > > On 09/03/2022 17:01, Jarkko Sakkinen wrote:
> > > > On Tue, Mar 08, 2022 at 05:02:23PM +0100, Micka=C3=ABl Sala=C3=BCn =
wrote:
> > > > >=20
> > > > > On 08/03/2022 14:19, Jarkko Sakkinen wrote:
> > > > > > On Tue, Mar 08, 2022 at 01:18:28PM +0100, Micka=C3=ABl Sala=C3=
=BCn wrote:
> > > > > > >=20
> > > > > > > On 08/03/2022 12:53, Jarkko Sakkinen wrote:
> > > > > > > > On Mon, Jul 12, 2021 at 07:03:13PM +0200, Micka=C3=ABl Sala=
=C3=BCn wrote:
> > > > > > > > > From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> > > > > > > > >=20
> > > > > > > > > Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enabl=
e the root user
> > > > > > > > > to dynamically add new keys to the blacklist keyring.=C2=
=A0 This enables to
> > > > > > > > > invalidate new certificates, either from being loaded in =
a keyring, or
> > > > > > > > > from being trusted in a PKCS#7 certificate chain.=C2=A0 T=
his also enables to
> > > > > > > > > add new file hashes to be denied by the integrity infrast=
ructure.
> > > > > > > > >=20
> > > > > > > > > Being able to untrust a certificate which could have norm=
aly been
> > > > > > > > > trusted is a sensitive operation.=C2=A0 This is why addin=
g new hashes to the
> > > > > > > > > blacklist keyring is only allowed when these hashes are s=
igned and
> > > > > > > > > vouched by the builtin trusted keyring.=C2=A0 A blacklist=
 hash is stored as a
> > > > > > > > > key description.=C2=A0 The PKCS#7 signature of this descr=
iption must be
> > > > > > > > > provided as the key payload.
> > > > > > > > >=20
> > > > > > > > > Marking a certificate as untrusted should be enforced whi=
le the system
> > > > > > > > > is running.=C2=A0 It is then forbiden to remove such blac=
klist keys.
> > > > > > > > >=20
> > > > > > > > > Update blacklist keyring, blacklist key and revoked certi=
ficate access rights:
> > > > > > > > > * allows the root user to search for a specific blacklist=
ed hash, which
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 make sense because the des=
criptions are already viewable;
> > > > > > > > > * forbids key update (blacklist and asymmetric ones);
> > > > > > > > > * restricts kernel rights on the blacklist keyring to ali=
gn with the
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root user rights.
> > > > > > > > >=20
> > > > > > > > > See help in tools/certs/print-cert-tbs-hash.sh .
> > > > > > > > >=20
> > > > > > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > > > > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > > > > > > > Cc: Eric Snowberg <eric.snowberg@oracle.com>
> > > > > > > > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.micros=
oft.com>
> > > > > > > > > Link: https://lore.kernel.org/r/20210712170313.884724-6-m=
ic@digikod.net
> > > > > > > > > ---
> > > > > > > > >=20
> > > > > > > > > Changes since v6:
> > > > > > > > > * Rebase on keys-cve-2020-26541-v3: commit ebd9c2ae369a (=
"integrity:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Load mokx variables into t=
he blacklist keyring").
> > > > > > > > >=20
> > > > > > > > > Changes since v5:
> > > > > > > > > * Rebase on keys-next, fix Kconfig conflict, and update t=
he asymmetric
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key rights added to the bl=
acklist keyring by the new
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add_key_to_revocation_list=
(): align with blacklist key rights by
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 removing KEY_POS_WRITE as =
a safeguard, and add
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEY_ALLOC_BYPASS_RESTRICTI=
ON to not be subject to
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restrict_link_for_blacklis=
t() that only allows blacklist key types to
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be added to the keyring.
> > > > > > > > > * Change the return code for restrict_link_for_blacklist(=
) from -EPERM
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to -EOPNOTSUPP to align wi=
th asymmetric key keyrings.
> > > > > > > > >=20
> > > > > > > > > Changes since v3:
> > > > > > > > > * Update commit message for print-cert-tbs-hash.sh .
> > > > > > > > >=20
> > > > > > > > > Changes since v2:
> > > > > > > > > * Add comment for blacklist_key_instantiate().
> > > > > > > > > ---
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 certs/Kconfig=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 +++++
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 certs/blacklist.c | 96 +++++++++=
+++++++++++++++++++++++++++-----------
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 2 files changed, 85 insertions(+=
), 21 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/certs/Kconfig b/certs/Kconfig
> > > > > > > > > index 0fbe184ceca5..e0e524b7eff9 100644
> > > > > > > > > --- a/certs/Kconfig
> > > > > > > > > +++ b/certs/Kconfig
> > > > > > > > > @@ -103,4 +103,14 @@ config SYSTEM_REVOCATION_KEYS
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntaining X.509 certificates to be included in the default blacklist
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ke=
yring.
> > > > > > > > > +config SYSTEM_BLACKLIST_AUTH_UPDATE
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Allow ro=
ot to add signed blacklist keys"
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on SYS=
TEM_BLACKLIST_KEYRING
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on SYS=
TEM_DATA_VERIFICATION
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If set,=
 provide the ability to load new blacklist keys at run time if
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 they ar=
e signed and vouched by a certificate from the builtin trusted
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keyring=
.=C2=A0 The PKCS#7 signature of the description is set in the key
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 payload=
.=C2=A0 Blacklist keys cannot be removed.
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 endmenu
> > > > > > > > > diff --git a/certs/blacklist.c b/certs/blacklist.c
> > > > > > > > > index b254c87ceb3a..486ce0dd8e9c 100644
> > > > > > > > > --- a/certs/blacklist.c
> > > > > > > > > +++ b/certs/blacklist.c
> > > > > > > > > @@ -15,6 +15,7 @@
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 #include <linux/err.h>
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 #include <linux/seq_file.h>
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 #include <linux/uidgid.h>
> > > > > > > > > +#include <linux/verification.h>
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 #include <keys/system_keyring.h>
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 #include "blacklist.h"
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 #include "common.h"
> > > > > > > > > @@ -26,6 +27,9 @@
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 #define MAX_HASH_LEN=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0128
> > > > > > > > > +#define BLACKLIST_KEY_PERM (KEY_POS_SEARCH | KEY_POS_VIE=
W | \
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEY_USR_SEARCH | KEY_USR_VIEW)
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 static const char tbs_prefix[] =
=3D "tbs";
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 static const char bin_prefix[] =
=3D "bin";
> > > > > > > > > @@ -80,19 +84,51 @@ static int blacklist_vet_description(=
const char *desc)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > -/*
> > > > > > > > > - * The hash to be blacklisted is expected to be in the d=
escription.=C2=A0 There will
> > > > > > > > > - * be no payload.
> > > > > > > > > - */
> > > > > > > > > -static int blacklist_preparse(struct key_preparsed_paylo=
ad *prep)
> > > > > > > > > +static int blacklist_key_instantiate(struct key *key,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct key_preparsed_payload *prep)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 {
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (prep->data=
len > 0)
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > > > > > +#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > > > > > > > > +#endif
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Sets safe d=
efault permissions for keys loaded by user space. */
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0key->perm =3D =
BLACKLIST_KEY_PERM;
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Skips the a=
uthentication step for builtin hashes, they are not
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * signed but =
still trusted.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (key->flags=
 & (1 << KEY_FLAG_BUILTIN))
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > > > > > > > > +
> > > > > > > > > +#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Verifies th=
e description's PKCS#7 signature against the builtin
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * trusted key=
ring.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D verify=
_pkcs7_signature(key->description,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0strlen(key->description), prep->data, prep->datalen,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
> > > > > > > > > +#else
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It should n=
ot be possible to come here because the keyring doesn't
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * have KEY_US=
R_WRITE and the only other way to call this function is
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for builtin=
 hashes.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WARN_ON_ONCE(1=
);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EPERM;
> > > > > > > > > +#endif
> > > > > > > > > +
> > > > > > > > > +out:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return generic=
_key_instantiate(key, prep);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > -static void blacklist_free_preparse(struct key_preparsed=
_payload *prep)
> > > > > > > > > +static int blacklist_key_update(struct key *key,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct key_preparsed_payload *prep)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EPERM;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 static void blacklist_describe(c=
onst struct key *key, struct seq_file *m)
> > > > > > > > > @@ -103,9 +139,8 @@ static void blacklist_describe(const =
struct key *key, struct seq_file *m)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 static struct key_type key_type_=
blacklist =3D {
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D "blacklist",
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.vet_desc=
ription=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D blacklist_vet_de=
scription,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.preparse=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D blacklist_preparse,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.free_preparse=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D blacklist_f=
ree_preparse,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.instantiate=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=
 generic_key_instantiate,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.instantiate=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=
 blacklist_key_instantiate,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.update=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D blacklist_key_update,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.describe=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D blacklist_describe,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > @@ -154,8 +189,7 @@ static int mark_raw_hash_blacklisted(=
const char *hash)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha=
sh,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NU=
LL,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((KEY=
_POS_ALL & ~KEY_POS_SETATTR) |
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 KEY_USR_VIEW),
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLACK=
LIST_KEY_PERM,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KE=
Y_ALLOC_NOT_IN_QUOTA |
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KE=
Y_ALLOC_BUILT_IN);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ER=
R(key)) {
> > > > > > > > > @@ -232,8 +266,10 @@ int add_key_to_revocation_list(const=
 char *data, size_t size)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NU=
LL,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da=
ta,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
ze,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((KEY=
_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW),
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEY_A=
LLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEY_P=
OS_VIEW | KEY_POS_READ | KEY_POS_SEARCH
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | KEY=
_USR_VIEW,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEY_A=
LLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | KEY=
_ALLOC_BYPASS_RESTRICTION);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ER=
R(key)) {
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err("Problem with revocation key =
(%ld)\n", PTR_ERR(key));
> > > > > > > > > @@ -260,25 +296,43 @@ int is_key_on_revocation_list(struc=
t pkcs7_message *pkcs7)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 #endif
> > > > > > > > > +static int restrict_link_for_blacklist(struct key *dest_=
keyring,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct key_type *type, const unio=
n key_payload *payload,
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct key *restrict_key)
> > > > > > > > > +{
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (type =3D=
=3D &key_type_blacklist)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EOPNOT=
SUPP;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Initialise the blacklist
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 static int __init blacklist_init=
(void)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 {
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const cha=
r *const *bl;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct key_res=
triction *restriction;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (regis=
ter_key_type(&key_type_blacklist) < 0)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0panic("Can't allocate system blackli=
st key type\n");
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0restriction =
=3D kzalloc(sizeof(*restriction), GFP_KERNEL);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!restricti=
on)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0panic("Can't allocate blacklist keyring=
 restriction\n");
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > This prevents me from taking this to my pull request. In mo=
derns standards,
> > > > > > > > no new BUG_ON(), panic() etc. should never added to the ker=
nel.
> > > > > > > >=20
> > > > > > > > I missed this in my review.
> > > > > > > >=20
> > > > > > > > This should rather be e.g.
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 restriction =3D kzalloc(sizeof(*restriction), GFP_KERNEL);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!restri=
ction) {
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err("Can't allocate blacklist key=
ring restriction\n");
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
> > > > > > > >=20
> > > > > > > > Unfortunately I need to drop this patch set, because adding=
 new panic()
> > > > > > > > is simply a no-go.
> > > > > > >=20
> > > > > > > I agree that panic() is not great in general, but I followed =
the other part
> > > > > > > of the code (just above) that do the same. This part of the k=
ernel should
> > > > > > > failed if critical memory allocation failed at boot time (onl=
y). It doesn't
> > > > > > > impact the kernel once it is running. I don't think that just=
 ignoring this
> > > > > > > error with return 0 is fine, after all it's a critical error =
right?
> > > > > >=20
> > > > > > It's not good reason enough to crash the whole kernel, even if =
it is a
> > > > > > critical error (e.g. run-time foresincs). Even WARN() is not re=
commended
> > > > > > these days [*].
> > > > >=20
> > > > > I think that what Greg said in this email is that WARN*() should =
only be
> > > > > used for cases that should never happen, it is definitely not dep=
recated,
> > > > > but WARN_ON_ONCE() may be a better idea though. WARN*() helps det=
ect such
> > > > > thought-to-be-impossible cases, that can happen e.g. with code re=
factoring.
> > > > >=20
> > > > > A lot of initialization/boot code (e.g. without user space nor ex=
ternal
> > > > > interactions, mostly __init functions) do panic if there is unexp=
ected and
> > > > > unrecoverable errors like failed memory allocations. I think hand=
ling such
> > > > > errors otherwise would be more complex for no benefit. Moreover, =
delegating
> > > > > such error handling to user space could create new (silent) issue=
s.
> > > >=20
> > > > To crash the whole kernel, you should be able to clearly explain wh=
y it
> > > > makes sense in the situation.
> > >=20
> > > If there is no enough memory to allocate 24 bytes (struct key_restric=
tion)
> > > during early boot, I really doubt the kernel can do much.
> > >=20
> > > >=20
> > > > > >=20
> > > > > > For the existing panic()-statements: I'm happy to review patche=
s that
> > > > > > render them out. >
> > > > > > Not sure tho, if this fails should it be then "everything black=
listed".
> > > > > > Just one thing to consider.
> > > > >=20
> > > > > Well, if it fail it will be "nothing will work afterwards". Do yo=
u have a
> > > > > working and useful scenario for this kind of error?
> > > >=20
> > > > So you have zero chances to get a shell without blacklist just to d=
o
> > > > kernel forensics?
> > >=20
> > > Right, I don't think the kernel can launch any process (nor continue =
early
> > > boot) if it cannot allocate 24 bytes.
> >=20
> > initcall is just wrong layer to choose to crash the kernel. It should b=
e
> > either do_initcall_level() or do_one_initcall() that should care about
> > this (or not care). You can print error message and return -ENODEV;
>=20
> Ok, I'll do that. Is it OK if I send you a patch fixing all panic calls=
=20
> from blacklist_init() and system_trusted_keyring_init() to apply after=
=20
> this series (with the panic call)?

Yes, and I still have not sent my PR, i.e. can include this if you
can provide me patches soonish (include that to the same series).

In the end of the day it comes to this: it's not a void function.
ATM the framework above does not do much at all but it is IMHO
going beyond the abstraction, which we should not do.

BR, Jarkko

