Return-Path: <linux-integrity+bounces-5624-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A373BA7D255
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 05:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607F71889419
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 03:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260E3213256;
	Mon,  7 Apr 2025 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib7GUncR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3D192D8E;
	Mon,  7 Apr 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995331; cv=none; b=X7kWPq5bqtsjIYSVDt01Bnb3v4qRaCFgzzYFj2RAexj8snHFEX9De7QVjW/fQ1hjwxe2m1ogbhLI8vupm4GCYSqzqp/JNVKFjzulcCLrFKnkX1/N6E+n5HNS7STKMhIBBrn5flvmcEzCL6rzbuAaDw29WO4dsRr4prlmbuo2DUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995331; c=relaxed/simple;
	bh=bTc1KqQ/qml9IyNeZIircEE9ArDM0SBO7cWrEeQDOg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOEgK3NVWsnFbYBzkEsa0S6ioaHN4COG+GwMmV45SWig02NtTDkLzyNfhZdtPtqoFViIrngtW52M/OqCGkfYNud6wDHbXvAQRBHGSmK9hZ9MTmJdgfEzl6+TigQqId8Uy2vBEg0YpByG9/p56YOVOX7Ru1FeAZQnRHzWWV5qBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib7GUncR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933EFC4CEE7;
	Mon,  7 Apr 2025 03:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743995330;
	bh=bTc1KqQ/qml9IyNeZIircEE9ArDM0SBO7cWrEeQDOg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ib7GUncRswcuuLZwHO8rBBRGPZXUywrBwZtqdQMBlHvNkkm4YD/Zy6qfZXIjDn4CN
	 bNeXW+cj8YCh6E53ftemXApE62LoHgp6OrlzEypzHykrFcJ824GEFuxWmKV49FXwRa
	 wGxmJOtpeBLT/gW13/Mz2UeYg3A+EPAgMvlbLtNaYqk7avLFBz4thV9YVOSXHdJTnn
	 EXWgt1dkqfqM3xerlxfvxQ8cGP135WZiAMetRb0p7InHHKQKr9/70fmvehqzNSCPGx
	 7+s283lB913j1oUB/E/m3nXEek2G5Zwh9Q6q5fk41MO3qOmogj644TaYLwOGSAMxxe
	 jF55hKnZwD8gA==
Date: Mon, 7 Apr 2025 11:08:30 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>, Eric Biggers
 <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, kernel@collabora.com, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-media@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH] docs: Remove literal markup from Documentation/ paths
Message-ID: <20250407110830.736cd160@sal.lan>
In-Reply-To: <20250404-doc-paths-unliteral-v1-1-74718785444e@collabora.com>
References: <20250404-doc-paths-unliteral-v1-1-74718785444e@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Fri, 04 Apr 2025 11:37:28 -0400
N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> escreveu:

> Given that the automarkup Sphinx plugin cross-references
> "Documentation/*.rst" strings in the text to the corresponding
> documents, surrounding those strings with the literal markup (``) not
> only adds unnecessary markup in the source files, but actually prevents
> the automatic cross-referencing to happen (as it doesn't happen in
> literal blocks).
>=20
> Remove all the occurrences of the literal markup in
> "Documentation/*.rst" paths, except when the actual source file is being
> referred. Also change the surrounding text when needed so it reads well
> both in the source and the web page (eg. 'see file Doc...' -> 'see
> Doc...').

Better to apply it after my kernel-doc.py patch series, as it also
touches some things like this. So, we might have a conflict with
this series.

>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  Documentation/admin-guide/mm/numa_memory_policy.rst       | 2 +-
>  Documentation/admin-guide/serial-console.rst              | 2 +-
>  Documentation/driver-api/dmaengine/client.rst             | 2 +-
>  Documentation/driver-api/nvdimm/security.rst              | 2 +-
>  Documentation/filesystems/fscrypt.rst                     | 4 ++--
>  Documentation/iio/adis16475.rst                           | 4 ++--
>  Documentation/iio/adis16480.rst                           | 4 ++--
>  Documentation/iio/adis16550.rst                           | 4 ++--
>  Documentation/iio/adxl380.rst                             | 4 ++--
>  Documentation/kernel-hacking/hacking.rst                  | 6 +++---
>  Documentation/kernel-hacking/locking.rst                  | 2 +-
>  Documentation/networking/dsa/b53.rst                      | 2 +-
>  Documentation/networking/dsa/bcm_sf2.rst                  | 2 +-
>  Documentation/networking/dsa/dsa.rst                      | 2 +-
>  Documentation/networking/dsa/lan9303.rst                  | 2 +-
>  Documentation/networking/phy-link-topology.rst            | 2 +-
>  Documentation/process/adding-syscalls.rst                 | 2 +-
>  Documentation/process/submit-checklist.rst                | 7 ++++---
>  Documentation/security/keys/trusted-encrypted.rst         | 4 ++--
>  Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 2 +-
>  Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst  | 2 +-
>  Documentation/userspace-api/media/v4l/diff-v4l.rst        | 2 +-
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++--
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst       | 2 +-
>  24 files changed, 36 insertions(+), 35 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Docume=
ntation/admin-guide/mm/numa_memory_policy.rst
> index a70f20ce1ffb4ffd0cdcb8e575dce5547c76e73a..e431a93c82a6ac0be1ea2504c=
727565293f3be77 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -13,7 +13,7 @@ document attempts to describe the concepts and APIs of =
the 2.6 memory policy
>  support.
> =20
>  Memory policies should not be confused with cpusets
> -(``Documentation/admin-guide/cgroup-v1/cpusets.rst``)
> +(Documentation/admin-guide/cgroup-v1/cpusets.rst)
>  which is an administrative mechanism for restricting the nodes from which
>  memory may be allocated by a set of processes. Memory policies are a
>  programming interface that a NUMA-aware application can take advantage o=
f.  When
> diff --git a/Documentation/admin-guide/serial-console.rst b/Documentation=
/admin-guide/serial-console.rst
> index 1609e7479249f0721fd0b4fbbd70eda13ffc09e4..70c067aad724e08fc11457b9a=
792da965809f116 100644
> --- a/Documentation/admin-guide/serial-console.rst
> +++ b/Documentation/admin-guide/serial-console.rst
> @@ -86,7 +86,7 @@ You will need to create a new device to use ``/dev/cons=
ole``. The official
>  ``/dev/console`` is now character device 5,1.
> =20
>  (You can also use a network device as a console.  See
> -``Documentation/networking/netconsole.rst`` for information on that.)
> +Documentation/networking/netconsole.rst for information on that.)
> =20
>  Here's an example that will use ``/dev/ttyS1`` (COM2) as the console.
>  Replace the sample values as needed.
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentatio=
n/driver-api/dmaengine/client.rst
> index d491e385d61a98b8a804cd823caf254a2dc62cf4..884b96bdf90081ad17a315b15=
132a7e5ada07e37 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -5,7 +5,7 @@ DMA Engine API Guide
>  Vinod Koul <vinod dot koul at intel.com>
> =20
>  .. note:: For DMA Engine usage in async_tx please see:
> -          ``Documentation/crypto/async-tx-api.rst``
> +          Documentation/crypto/async-tx-api.rst
> =20
> =20
>  Below is a guide to device driver writers on how to use the Slave-DMA AP=
I of the
> diff --git a/Documentation/driver-api/nvdimm/security.rst b/Documentation=
/driver-api/nvdimm/security.rst
> index eb3d35e6a95c9faf683fd9591d0ea10a1264ec49..6bb732d08fc698b1c3d37263e=
78ad194081d46f2 100644
> --- a/Documentation/driver-api/nvdimm/security.rst
> +++ b/Documentation/driver-api/nvdimm/security.rst
> @@ -51,7 +51,7 @@ all the keys are in the kernel user keyring for unlock.
>  A nvdimm encrypted-key of format enc32 has the description format of:
>  nvdimm:<bus-provider-specific-unique-id>
> =20
> -See file ``Documentation/security/keys/trusted-encrypted.rst`` for creat=
ing
> +See Documentation/security/keys/trusted-encrypted.rst for creating
>  encrypted-keys of enc32 format. TPM usage with a master trusted key is
>  preferred for sealing the encrypted-keys.
> =20
> diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesy=
stems/fscrypt.rst
> index e803299085492217f946fafd79f2bbaf85a7f974..7aae828ae9040586bbd0bde00=
9386855c11e1645 100644
> --- a/Documentation/filesystems/fscrypt.rst
> +++ b/Documentation/filesystems/fscrypt.rst
> @@ -873,7 +873,7 @@ as follows:
>    hash of the key.  To add this type of key, the calling process does
>    not need any privileges.  However, the number of keys that can be
>    added is limited by the user's quota for the keyrings service (see
> -  ``Documentation/security/keys/core.rst``).
> +  Documentation/security/keys/core.rst).
> =20
>  - ``raw_size`` must be the size of the ``raw`` key provided, in bytes.
>    Alternatively, if ``key_id`` is nonzero, this field must be 0, since
> @@ -955,7 +955,7 @@ access encrypted files.
> =20
>  Nevertheless, to add a key to one of the process-subscribed keyrings,
>  the add_key() system call can be used (see:
> -``Documentation/security/keys/core.rst``).  The key type must be
> +Documentation/security/keys/core.rst).  The key type must be
>  "logon"; keys of this type are kept in kernel memory and cannot be
>  read back by userspace.  The key description must be "fscrypt:"
>  followed by the 16-character lower case hex representation of the
> diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis1647=
5.rst
> index 4bf0998be36efced97ecb93372df84790351e36b..89a388490ab735f6f4bc1c4dd=
a10a87881ae82aa 100644
> --- a/Documentation/iio/adis16475.rst
> +++ b/Documentation/iio/adis16475.rst
> @@ -374,11 +374,11 @@ Obtain buffered data:
>          00001740  01 1a 00 00 ff ff fe 31  00 00 46 aa 00 03 37 f7  |...=
....1..F...7.|
>          ...
> =20
> -See ``Documentation/iio/iio_devbuf.rst`` for more information about how =
buffered
> +See Documentation/iio/iio_devbuf.rst for more information about how buff=
ered
>  data is structured.
> =20
>  4. IIO Interfacing Tools
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -See ``Documentation/iio/iio_tools.rst`` for the description of the avail=
able IIO
> +See Documentation/iio/iio_tools.rst for the description of the available=
 IIO
>  interfacing tools.
> diff --git a/Documentation/iio/adis16480.rst b/Documentation/iio/adis1648=
0.rst
> index 4a2d40e0daa7989dd9dc7c1991de24ac6184fb0c..cce5f3e0174158cf20f12e96b=
ff5c79bced84aab 100644
> --- a/Documentation/iio/adis16480.rst
> +++ b/Documentation/iio/adis16480.rst
> @@ -436,11 +436,11 @@ Obtain buffered data::
>    00006b60  09 63 00 00 00 00 1b 13  00 00 22 2f 00 03 23 91  |.c.......=
."/..#.|
>    ...
> =20
> -See ``Documentation/iio/iio_devbuf.rst`` for more information about how =
buffered
> +See Documentation/iio/iio_devbuf.rst for more information about how buff=
ered
>  data is structured.
> =20
>  4. IIO Interfacing Tools
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -See ``Documentation/iio/iio_tools.rst`` for the description of the avail=
able IIO
> +See Documentation/iio/iio_tools.rst for the description of the available=
 IIO
>  interfacing tools.
> diff --git a/Documentation/iio/adis16550.rst b/Documentation/iio/adis1655=
0.rst
> index 25db7b8060c42153f9acbc1b5dd689c79f8da70b..c9bbc0a857b03bc1894e3fbba=
792bba705966636 100644
> --- a/Documentation/iio/adis16550.rst
> +++ b/Documentation/iio/adis16550.rst
> @@ -366,11 +366,11 @@ Obtain buffered data:
>          0000ceb0  00 00 0d 2f 00 00 05 25  00 00 07 8d 00 00 a2 ce  |...=
/...%........|
>          ...
> =20
> -See ``Documentation/iio/iio_devbuf.rst`` for more information about how =
buffered
> +See Documentation/iio/iio_devbuf.rst for more information about how buff=
ered
>  data is structured.
> =20
>  4. IIO Interfacing Tools
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -See ``Documentation/iio/iio_tools.rst`` for the description of the avail=
able IIO
> +See Documentation/iio/iio_tools.rst for the description of the available=
 IIO
>  interfacing tools.
> diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
> index 66c8a4d4f767e5a6faa20b1c0fad57b954624a95..61cafa2f98bf36e4c1b035fc4=
ffd73fab6b2058d 100644
> --- a/Documentation/iio/adxl380.rst
> +++ b/Documentation/iio/adxl380.rst
> @@ -223,11 +223,11 @@ Obtain buffered data:
>          002bc3c0  f7 fd 00 cb fb 94 24 80  f7 e3 00 f2 fb b8 24 80  |...=
...$.......$.|
>          ...
> =20
> -See ``Documentation/iio/iio_devbuf.rst`` for more information about how =
buffered
> +See Documentation/iio/iio_devbuf.rst for more information about how buff=
ered
>  data is structured.
> =20
>  4. IIO Interfacing Tools
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -See ``Documentation/iio/iio_tools.rst`` for the description of the avail=
able IIO
> +See Documentation/iio/iio_tools.rst for the description of the available=
 IIO
>  interfacing tools.
> diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/ker=
nel-hacking/hacking.rst
> index 0042776a9e17cfc5d09b5de043cd4131b54192a9..53cf502ccf3706b15b7c1da17=
7cc28d6decee2b3 100644
> --- a/Documentation/kernel-hacking/hacking.rst
> +++ b/Documentation/kernel-hacking/hacking.rst
> @@ -736,7 +736,7 @@ make a neat patch, there's administrative work to be =
done:
>  -  Usually you want a configuration option for your kernel hack. Edit
>     ``Kconfig`` in the appropriate directory. The Config language is
>     simple to use by cut and paste, and there's complete documentation in
> -   ``Documentation/kbuild/kconfig-language.rst``.
> +   Documentation/kbuild/kconfig-language.rst.
> =20
>     In your description of the option, make sure you address both the
>     expert user and the user who knows nothing about your feature.
> @@ -746,7 +746,7 @@ make a neat patch, there's administrative work to be =
done:
> =20
>  -  Edit the ``Makefile``: the CONFIG variables are exported here so you
>     can usually just add a "obj-$(CONFIG_xxx) +=3D xxx.o" line. The syntax
> -   is documented in ``Documentation/kbuild/makefiles.rst``.
> +   is documented in Documentation/kbuild/makefiles.rst.
> =20
>  -  Put yourself in ``CREDITS`` if you consider what you've done
>     noteworthy, usually beyond a single file (your name should be at the
> @@ -755,7 +755,7 @@ make a neat patch, there's administrative work to be =
done:
>     it implies a more-than-passing commitment to some part of the code.
> =20
>  -  Finally, don't forget to read
> -   ``Documentation/process/submitting-patches.rst``
> +   Documentation/process/submitting-patches.rst
> =20
>  Kernel Cantrips
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/ker=
nel-hacking/locking.rst
> index dff0646a717bff27f6b82d3a8090876e99d23cec..d479c2459895cd8cd5df5b2c9=
180aafb19f8b7fb 100644
> --- a/Documentation/kernel-hacking/locking.rst
> +++ b/Documentation/kernel-hacking/locking.rst
> @@ -1370,7 +1370,7 @@ Futex API reference
>  Further reading
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> --  ``Documentation/locking/spinlocks.rst``: Linus Torvalds' spinlocking
> +-  Documentation/locking/spinlocks.rst: Linus Torvalds' spinlocking
>     tutorial in the kernel sources.
> =20
>  -  Unix Systems for Modern Architectures: Symmetric Multiprocessing and
> diff --git a/Documentation/networking/dsa/b53.rst b/Documentation/network=
ing/dsa/b53.rst
> index 1cb3ff648f8890ea1063789672f19a1fea9f01e5..51fd39ca52019c84ab5583321=
38e94f34aa3c293 100644
> --- a/Documentation/networking/dsa/b53.rst
> +++ b/Documentation/networking/dsa/b53.rst
> @@ -14,7 +14,7 @@ Implementation details
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The driver is located in ``drivers/net/dsa/b53/`` and is implemented as a
> -DSA driver; see ``Documentation/networking/dsa/dsa.rst`` for details on =
the
> +DSA driver; see Documentation/networking/dsa/dsa.rst for details on the
>  subsystem and what it provides.
> =20
>  The switch is, if possible, configured to enable a Broadcom specific 4-b=
ytes
> diff --git a/Documentation/networking/dsa/bcm_sf2.rst b/Documentation/net=
working/dsa/bcm_sf2.rst
> index d2571435696f6b777fa682660b9e5310bad765c1..ba7371aad142408a9d95644c4=
7813cba968affc2 100644
> --- a/Documentation/networking/dsa/bcm_sf2.rst
> +++ b/Documentation/networking/dsa/bcm_sf2.rst
> @@ -39,7 +39,7 @@ Implementation details
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The driver is located in ``drivers/net/dsa/bcm_sf2.c`` and is implemente=
d as a DSA
> -driver; see ``Documentation/networking/dsa/dsa.rst`` for details on the =
subsystem
> +driver; see Documentation/networking/dsa/dsa.rst for details on the subs=
ystem
>  and what it provides.
> =20
>  The SF2 switch is configured to enable a Broadcom specific 4-bytes switc=
h tag
> diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/network=
ing/dsa/dsa.rst
> index 7b2e69cd7ef0b92f1da4666581c03d07928e6e1b..6e185a08396b91ea8bbfeec31=
302527555df0cfd 100644
> --- a/Documentation/networking/dsa/dsa.rst
> +++ b/Documentation/networking/dsa/dsa.rst
> @@ -1110,7 +1110,7 @@ interface with a physical switch port does not prod=
uce the expected result).
> =20
>  A driver which is able of offloading certain functions of a DANP or DANH=
 should
>  declare the corresponding netdev features as indicated by the documentat=
ion at
> -``Documentation/networking/netdev-features.rst``. Additionally, the foll=
owing
> +Documentation/networking/netdev-features.rst. Additionally, the following
>  methods must be implemented:
> =20
>  - ``port_hsr_join``: function invoked when a given switch port is added =
to a
> diff --git a/Documentation/networking/dsa/lan9303.rst b/Documentation/net=
working/dsa/lan9303.rst
> index ab81b4e0139e340e7025c7b1e1fb0ddd65b232ff..97456316a8d9ec42ef7eb3477=
36d6a9e0de08869 100644
> --- a/Documentation/networking/dsa/lan9303.rst
> +++ b/Documentation/networking/dsa/lan9303.rst
> @@ -10,7 +10,7 @@ host conduit network interface (e.g. fixed link).
>  Driver details
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -The driver is implemented as a DSA driver, see ``Documentation/networkin=
g/dsa/dsa.rst``.
> +The driver is implemented as a DSA driver, see Documentation/networking/=
dsa/dsa.rst.
> =20
>  See ``Documentation/devicetree/bindings/net/dsa/lan9303.txt`` for device=
 tree
>  binding.
> diff --git a/Documentation/networking/phy-link-topology.rst b/Documentati=
on/networking/phy-link-topology.rst
> index 4dec5d7d6513d9946ccdabd6733228aa61ff1ea1..ff01d70ef61b42909ec4b3ab6=
730a08c4b271505 100644
> --- a/Documentation/networking/phy-link-topology.rst
> +++ b/Documentation/networking/phy-link-topology.rst
> @@ -98,7 +98,7 @@ UAPI
>  =3D=3D=3D=3D
> =20
>  There exist a set of netlink commands to query the link topology from us=
erspace,
> -see ``Documentation/networking/ethtool-netlink.rst``.
> +see Documentation/networking/ethtool-netlink.rst.
> =20
>  The whole point of having a topology representation is to assign the phy=
index
>  field in :c:type:`struct phy_device <phy_device>`. This index is reporte=
d to
> diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/pr=
ocess/adding-syscalls.rst
> index 906c47f1a9e5086a1c5f451b1d8bebe19b0c6ff0..5e6d26ef31eb937f43e74e919=
3dbecb8bfa5ae14 100644
> --- a/Documentation/process/adding-syscalls.rst
> +++ b/Documentation/process/adding-syscalls.rst
> @@ -33,7 +33,7 @@ interface.
>         to a somewhat opaque API.
> =20
>   - If you're just exposing runtime system information, a new node in sys=
fs
> -   (see ``Documentation/filesystems/sysfs.rst``) or the ``/proc`` filesy=
stem may
> +   (see Documentation/filesystems/sysfs.rst) or the ``/proc`` filesystem=
 may
>     be more appropriate.  However, access to these mechanisms requires th=
at the
>     relevant filesystem is mounted, which might not always be the case (e=
.g.
>     in a namespaced/sandboxed/chrooted environment).  Avoid adding any AP=
I to
> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/p=
rocess/submit-checklist.rst
> index beb7f94279fdb6a1d9b4aa86b2bea031f140732b..3ae31c5af2cb5c374658c1fb7=
125e70bf36e911c 100644
> --- a/Documentation/process/submit-checklist.rst
> +++ b/Documentation/process/submit-checklist.rst
> @@ -30,7 +30,8 @@ Review Kconfig changes
> =20
>  1) Any new or modified ``CONFIG`` options do not muck up the config menu=
 and
>     default to off unless they meet the exception criteria documented in
> -   ``Documentation/kbuild/kconfig-language.rst`` Menu attributes: defaul=
t value.
> +   Documentation/kbuild/kconfig-language.rst, under "Menu attributes", "=
default
> +   value".
> =20
>  2) All new ``Kconfig`` options have help text.
> =20
> @@ -47,7 +48,7 @@ Provide documentation
>  2) All new ``/proc`` entries are documented under ``Documentation/``
> =20
>  3) All new kernel boot parameters are documented in
> -   ``Documentation/admin-guide/kernel-parameters.rst``.
> +   Documentation/admin-guide/kernel-parameters.rst.
> =20
>  4) All new module parameters are documented with ``MODULE_PARM_DESC()``
> =20
> @@ -58,7 +59,7 @@ Provide documentation
>     linux-api@vger.kernel.org.
> =20
>  6) If any ioctl's are added by the patch, then also update
> -   ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
> +   Documentation/userspace-api/ioctl/ioctl-number.rst.
> =20
>  Check your code with tools
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Document=
ation/security/keys/trusted-encrypted.rst
> index f4d7e162d5e475bf01baafcd4dbbd9dfda9f5e6f..7eef16778ae4f43f6ee538ae4=
317f0c3d48c3c7f 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -107,7 +107,7 @@ safe.
>       (2) TEE
> =20
>           TEEs have well-documented, standardized client interface and AP=
Is. For
> -         more details refer to ``Documentation/driver-api/tee.rst``.
> +         more details refer to Documentation/driver-api/tee.rst.
> =20
>       (3) CAAM
> =20
> @@ -407,7 +407,7 @@ Other uses for trusted and encrypted keys, such as fo=
r disk and file encryption
>  are anticipated.  In particular the new format 'ecryptfs' has been defin=
ed
>  in order to use encrypted keys to mount an eCryptfs filesystem.  More de=
tails
>  about the usage can be found in the file
> -``Documentation/security/keys/ecryptfs.rst``.
> +Documentation/security/keys/ecryptfs.rst.
> =20
>  Another new format 'enc32' has been defined in order to support encrypte=
d keys
>  with payload size of 32 bytes. This will initially be used for nvdimm se=
curity
> diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/=
Documentation/sound/kernel-api/writing-an-alsa-driver.rst
> index 895752cbcedd6b1202ff481cbae6f5001dd3d903..975e9dfb29009f481e7bae243=
285d2a93a82f5dc 100644
> --- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
> +++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
> @@ -2466,7 +2466,7 @@ Mic boost
>  Mic-boost switch is set as =E2=80=9CMic Boost=E2=80=9D or =E2=80=9CMic B=
oost (6dB)=E2=80=9D.
> =20
>  More precise information can be found in
> -``Documentation/sound/designs/control-names.rst``.
> +Documentation/sound/designs/control-names.rst.
> =20
>  Access Flags
>  ------------
> diff --git a/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst b/D=
ocumentation/userspace-api/media/v4l/dev-sliced-vbi.rst
> index 42cdb0a9f786066a2d4b8ebc2c72a9318dabebf5..d7524b65a2fccc5ce16abcac7=
aae3ae0f9f461c7 100644
> --- a/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
> +++ b/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
> @@ -430,7 +430,7 @@ MPEG stream.
>  *Historical context*: This format specification originates from a
>  custom, embedded, sliced VBI data format used by the ``ivtv`` driver.
>  This format has already been informally specified in the kernel sources
> -in the file ``Documentation/userspace-api/media/drivers/cx2341x-uapi.rst=
`` . The
> +in Documentation/userspace-api/media/drivers/cx2341x-uapi.rst. The
>  maximum size of the payload and other aspects of this format are driven
>  by the CX23415 MPEG decoder's capabilities and limitations with respect
>  to extracting, decoding, and displaying sliced VBI data embedded within
> diff --git a/Documentation/userspace-api/media/v4l/diff-v4l.rst b/Documen=
tation/userspace-api/media/v4l/diff-v4l.rst
> index 33243ecb50336abe845aa44232917134b21280f7..b087835a147fc0a2285992b8d=
2bc9a56e83b1cb7 100644
> --- a/Documentation/userspace-api/media/v4l/diff-v4l.rst
> +++ b/Documentation/userspace-api/media/v4l/diff-v4l.rst
> @@ -634,7 +634,7 @@ devices is documented in :ref:`extended-controls`.
>     compatible with V4L or V4L2.
> =20
>  .. [#f2]
> -   According to ``Documentation/admin-guide/devices.rst`` a symbolic lin=
k to
> +   According to Documentation/admin-guide/devices.rst a symbolic link to
>     ``/dev/radio0``.
> =20
>  .. [#f3]
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/=
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 4a379bd9e3fbdb78dfda8e7bc4b25de079d61208..7b463d1ffc906a6b519cc7c2f=
2d6526c3e53eae5 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -108,8 +108,8 @@ enum v4l2_mpeg_stream_vbi_fmt -
>        - No VBI in the MPEG stream
>      * - ``V4L2_MPEG_STREAM_VBI_FMT_IVTV``
>        - VBI in private packets, IVTV format (documented in the kernel
> -	sources in the file
> -	``Documentation/userspace-api/media/drivers/cx2341x-uapi.rst``)
> +	sources in
> +	Documentation/userspace-api/media/drivers/cx2341x-uapi.rst)
> =20
> =20
> =20
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Docume=
ntation/virt/uml/user_mode_linux_howto_v2.rst
> index 584000b743f381747f7bced26d60f0d92b6c1fbe..71d1258a5002acb4716221351=
b60579892862cca 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -1118,7 +1118,7 @@ new feature, please send it to ``linux-um@lists.inf=
radead.org``.
> =20
>  Please follow all standard Linux patch guidelines such as cc-ing
>  relevant maintainers and run ``./scripts/checkpatch.pl`` on your patch.
> -For more details see ``Documentation/process/submitting-patches.rst``
> +For more details see Documentation/process/submitting-patches.rst
> =20
>  Note - the list does not accept HTML or attachments, all emails must
>  be formatted as plain text.
>=20
> ---
> base-commit: 405e2241def89c88f008dcb899eb5b6d4be8b43c
> change-id: 20250404-doc-paths-unliteral-b9d2bd13a4bd
>=20
> Best regards,

