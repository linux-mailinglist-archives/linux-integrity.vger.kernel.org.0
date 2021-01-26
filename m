Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA2630429B
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Jan 2021 16:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406349AbhAZPaL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Jan 2021 10:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405881AbhAZPaI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jan 2021 10:30:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78AD822B51;
        Tue, 26 Jan 2021 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611674968;
        bh=IXgxR80n9iJ/4KZiqA0JVNszP1+TmyfHwJ2kzzmCRq8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RbtYhbmyTR5MmsmrUlByLQD+cw2nZgA0x7Z7OlD7b6kleyrx5YNODCMbtJB7zOyZf
         1aURouEKfFkh1LslPKGRdTNwrtDrQHhMof5zMM0FBmRW+ThQOPVT3fEneRLNiS90DF
         GCECFcnlJ1gUER5NEt6LzYi8RY4+5yY9+6HrUMVpieSQZ1UDj6lBN6oB4nrXmPboRp
         9smQDVviLVy97LdJlkfhQeLOV8PZn4difT/aym0Mug7Zuva7+eK9cGPWx/UNs6wopu
         p6C9zMnnw7YhcqDdaruV6NxSHD5uS2e4h+wy/kUuyQwBtyZsCfcIUmeGOAruuZL00f
         cfx2tJUkCeBAA==
Message-ID: <a4ecfaf99f322c752d6422056d4ea94f9b3d962b.camel@kernel.org>
Subject: Re: [PATCH 3/4] tpm: in tpm2_del_space check if ops pointer is
 still valid
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date:   Tue, 26 Jan 2021 17:29:23 +0200
In-Reply-To: <9bb612ef-75be-f8d4-10a6-7ab5869da18f@gmx.de>
References: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
         <1610760161-21982-4-git-send-email-LinoSanfilippo@gmx.de>
         <YAR+R0c8HYsVUhZQ@kernel.org> <9bb612ef-75be-f8d4-10a6-7ab5869da18f@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-01-24 at 17:47 +0100, Lino Sanfilippo wrote:
>=20
> Hi Jarkko,
>=20
> On 17.01.21 at 19:13, Jarkko Sakkinen wrote:
> >=20
> > I have hard time to believe that any of these patches are based on
> > actual regressions.
> >=20
> > /Jarko
> >=20
>=20
> patch 1 is indeed wrong (I oversaw the action call in case of error),
> so please ignore it.
>=20
> However patches 2 and 3 are based on bugs I encountered while working wit=
h
> TPM. I am sorry if I did not make the issues clear enough in the patches
> commit messages. Let me try to explain it in more detail:
>=20
> The bugs showed up after unloading the TPM chip driver module while one
> process still had the /dev/tpmrm device open.

Please refine the patch set, and we will look into that then.

Put fixes tags and logs where appropriate. Thanks.

/Jarkko
