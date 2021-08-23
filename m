Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443843F4FEB
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhHWRwe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 13:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhHWRw1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 13:52:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6BF061361;
        Mon, 23 Aug 2021 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629741101;
        bh=09+/dl+7N1j1ONGcVKQNxk5N6MkJgtGVdyKJOEXl42o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R7I+4yYJx/fWc5zJEUrabQN5jWQhkkYvErEClrnuWFWTit/nYJLoWwz2BmJHQQ9Nw
         debJanht7MFAtZ1k9/ftlVBvyRZqN2umeHq7unJ/FArlgS7XbL6WEyEfVy+vfcu7nV
         qqb3hWiWAESsXuyJdx3ez/t7y3Lei+hCvh9lg/wWoDauq3FzENQCvncWud+v6SHrGO
         6FT3ebfNld1YUrV8rI6ylryMvJGFHj0HDxB5KhBB1jkcJo2bXhfgrTz+EFmKMAXszq
         p1sTL17ZLtBLHWbLlRJLwXMT2vmeKuAspAmtCXrQpsnq9L6yyXt0XPn0BGe6m1OoSv
         ggQKmgItgx2Iw==
Message-ID: <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Mon, 23 Aug 2021 20:51:39 +0300
In-Reply-To: <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
         <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
         <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
         <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
         <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 13:32 -0400, Mimi Zohar wrote:
> On Thu, 2021-08-19 at 09:23 -0600, Eric Snowberg wrote:
> > > On Aug 19, 2021, at 7:10 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >=20
> > > On Thu, 2021-08-19 at 14:38 +0300, Jarkko Sakkinen wrote:
> > > > On Wed, 2021-08-18 at 20:20 -0400, Eric Snowberg wrote:
> > > > > Downstream Linux distros try to have a single signed kernel for e=
ach
> > > > > architecture.  Each end-user may use this kernel in entirely diff=
erent
> > > > > ways.  Some downstream kernels have chosen to always trust platfo=
rm keys
> > > > > within the Linux trust boundary for kernel module signing.  These
> > > > > kernels have no way of using digital signature base IMA appraisal=
.
> > > > >=20
> > > > > This series introduces a new Linux kernel keyring containing the =
Machine
> > > > > Owner Keys (MOK) called .mok. It also adds a new MOK variable to =
shim.
> > > >=20
> > > > I would name it as ".machine" because it is more "re-usable" name, =
e.g.
> > > > could be used for similar things as MOK. ".mok" is a bad name becau=
se
> > > > it binds directly to a single piece of user space software.
> > >=20
> > > Nayna previously said,
> > >   "I believe the underlying source from where CA keys are loaded migh=
t vary=20
> > >   based on the architecture (".mok" is UEFI specific.). The key part =
is=20
> > >   that this new keyring should contain only CA keys which can be late=
r=20
> > >   used to vouch for user keys loaded onto IMA or secondary keyring at=
=20
> > >   runtime. It would be good to have a "ca" in the name, like .xxxx-ca=
,=20
> > >   where xxxx can be machine, owner, or system. I prefer .system-ca."
> > >=20
> > > The CA keys on the MOK db is simply the first root of trust being
> > > defined, but other roots of trust are sure to follow.  For this reaso=
n,
> > > I agree naming the new keyring "mok" should be avoided.
> >=20
> > As I said previously, I=E2=80=99m open to renaming, I just would like t=
o have an=20
> > agreement on the new name before changing everything.  The current prop=
osed=20
> > names I have heard are =E2=80=9C.machine" and ".system-ca".  Is there a=
 preference=20
> > the maintainers feel is appropriate?  If so, please let me know and I=
=E2=80=99ll=20
> > rename it. Thanks.
> >=20
>=20
> Jarkko, I think the emphasis should not be on "machine" from Machine
> Owner Key (MOK), but on "owner".  Whereas Nayna is focusing more on the
> "_ca" aspect of the name.   Perhaps consider naming it
> "system_owner_ca" or something along those lines.

What do you gain such overly long identifier? Makes no sense. What=20
is "ca aspect of the name" anyway?

/Jarkko
