Return-Path: <linux-integrity+bounces-6350-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19006ACAEEF
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Jun 2025 15:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B6C17FDC3
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Jun 2025 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9192E221543;
	Mon,  2 Jun 2025 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLpqBTkH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7721C9EF
	for <linux-integrity@vger.kernel.org>; Mon,  2 Jun 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870756; cv=none; b=r7mxUzhF9nouo/Gb7EWeNX79aC9N6oiI6sACSXzn6aTkfu9YSwgvAK07VgknvYo6IN9lgiEDYkTLdErjj8t+7k7ioxrnFWw4awsBbdNdi/K/i7ZOaF52Wgj/9Ud3tHt6EvqO3GaFZMIAYVieMsGOt5P6G+mKpq29GdRCEDixitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870756; c=relaxed/simple;
	bh=bfes8zZB5azdrucRkZ0R+StBkCNzaum0W5A5blaEZAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETKrK9w9LwN8Eg9jxBhUC2zAybBQBgyHsiLqaptvU9/sbfU9TIj0Q7CBBoU3rGESATT3RV3vOyN2gmT5S9dp9rLcLmewlA/IAzqLo0w3PgK9crmLzjTxFyGzQurztlTeYJVzXv4V1YbSRvjoYvl8dzx5dk9DskQgCIfPVax9Hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLpqBTkH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748870753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=badVlBQqQnqQ+WuvslSW3Ky30eTx0uVb3Tc6t4qkrJM=;
	b=MLpqBTkHHjL9L6C1qDPr/gUILv31s45SmXHNsamJV104M5VM9YvXLLHN9Fwbq9AU7fWNdM
	oVPJxIpthtc9yx0QiE3Ba1EKiDvwqRx3jlM7BWVxRKYI1KUVJ1D868ewTAcTgXoTDMNj5H
	qRmOC0pJPNE8UShIGwsHjxJHizSwkng=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-7h5M09zkPwSRZFablYj2gw-1; Mon,
 02 Jun 2025 09:25:50 -0400
X-MC-Unique: 7h5M09zkPwSRZFablYj2gw-1
X-Mimecast-MFC-AGG-ID: 7h5M09zkPwSRZFablYj2gw_1748870746
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5F3E1800366;
	Mon,  2 Jun 2025 13:25:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.87])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B353818003FD;
	Mon,  2 Jun 2025 13:25:36 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Jones <pjones@redhat.com>,
	Robert Holmes <robeholmes@gmail.com>,
	Jeremy Cline <jcline@redhat.com>,
	Coiby Xu <coxu@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH RFC 0/1] module: Optionally use .platform keyring for signatures verification
Date: Mon,  2 Jun 2025 15:25:34 +0200
Message-ID: <20250602132535.897944-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

UEFI SecureBoot 'db' keys are currently not trusted for modules signatures
verification. RedHat based downstream distros (RHEL, Fedora, ...) carry a
patch changing that for many years (since 2019 at least). This RFC is an
attempt to upstream it as the functionality seems to be generally useful.

Previously, pre-boot keys (SecureBoot 'db', MOK) were not trusted within
kernel at all. Things have changed since '.machine' keyring got introduced
making MOK keys optionally trusted. Before that, there was a discussion to
make .platform trusted by default:
https://lore.kernel.org/lkml/1556116431-7129-1-git-send-email-robeholmes@gmail.com/
which didn't go very far because the assumption was that this is only useful
when the user has control over 'db'. I believe there's a fairly common
use-case where this is true.

The use-case: virtualized and cloud infrastructure generally provide an
ability to customize SecureBoot variables, in particular, it is possible
to bring your own SecureBoot 'db'. This may come handy when a user wants to
load a third party kernel module (self built or provided by a third party
vendor) while still using a distro provided kernel. Generally, distro
provided kernels sign modules with an ephemeral key and discard the private
part during the build. While MOK can sometimes be used to sign something
out-of-tree, it is a tedious process requiring either a manual intervention
with shim or a 'certmule' 
(see https://blogs.oracle.com/linux/post/the-machine-keyring). In contrast,
the beauty of using SecureBoot 'db' in this scenario is that for public
clouds and virtualized infrastructure it is normally a property of the OS
image (or the whole infrastructure/host) and not an individual instance;
this means that all instances created from the same template will have 'db'
keys in '.platform' by default.

The suggested approach is not to change the default, but to introduce a
Kconfig variable (CONFIG_MODULE_SIG_PLATFORM) doing the job. Note, the 
kernel already trusts '.platform' for kexec (see commit 278311e417be 
("kexec, KEYS: Make use of platform keyring for signature verify"))
and dm-verity (see commit 6fce1f40e951 ("dm verity: add support for
signature verification with platform keyring")) so maybe changing the
default or introducing a generic '.plarform is fully trusted' option
would actually be better.

Vitaly Kuznetsov (1):
  module: Make use of platform keyring for module signature verify

 Documentation/admin-guide/module-signing.rst |  6 ++++++
 kernel/module/Kconfig                        | 11 +++++++++++
 kernel/module/signing.c                      |  9 ++++++++-
 security/integrity/Kconfig                   |  2 +-
 4 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.49.0


