Return-Path: <linux-integrity+bounces-8918-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NlmFclOqWk14AAAu9opvQ
	(envelope-from <linux-integrity+bounces-8918-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 10:37:13 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B1220EA12
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F3DC3105620
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F371379EE1;
	Thu,  5 Mar 2026 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQXldCJK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQopPuU3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E3379964;
	Thu,  5 Mar 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703105; cv=none; b=Bv/E37UKhH+l5aUgAGLH8Yg9FQiggMAAtzsNz/pJ22ZlYAcIHqyaF1Xn6O2lXQEL2d/XhZVA6tCI9zaW+Br/lXhGCLfWKJzqSvKQ8p5JDxLK1TH+gK7Nv+x5RaXbmD084l/DutD5icwkpeJWEhG4irkIDFCEC3VGUMJjQagP9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703105; c=relaxed/simple;
	bh=lm2zdd1A7Pa39t7QGFEXw1w4jepGk8HgTJnI9lzo6So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mc6ctPZ/hoHZ6ev59dABLbqI/TLdlXtO/L+Qnv/67QCLXQAMkr0fyv9O2f+GEOzkLRJFiwNCtbRWS6VX7/X0Gm5asY6Lps8Ir4k8eNESmRGIS72jHxZnpYvDTWHRJLjyFsBF2bQzDQkTxGJsE4QpxAGsnYBFEHzq5mEy74DrOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQXldCJK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQopPuU3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772703101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyqXPUmQIvIGFxEm9KyWySX9eEIsRTDaevUpvtqQ49Y=;
	b=HQXldCJKBopciJJU+DV8+MAPdJggkbPh1WBCLiDKu+e3q8cVK5mDQe3Wu+nYYFerejQ/qP
	RWxY00Hob1EbR52b/16T0xv6k39VGwbMSnS9LHFDsnAjXllMhvsE0mstuwIywW/uhvK/r6
	wTwoNzOl3wmCTgC32JboFjhF17ojzK87fFZAeG3VswqlFvOegQUB3jLdLqyJSfOTei5wjR
	DZFfSygIjR0xopVqVlskg7+K9ArWHCsBhKkqpkJ4O6p4COTrDV37qnuEygOl67Rs4kckRn
	uUdwK1mdlJ4NHNyohf7+oSIpgfo/CT8THgZEW9p4OzFkxDVIUpQv+FLfuWPRgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772703101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyqXPUmQIvIGFxEm9KyWySX9eEIsRTDaevUpvtqQ49Y=;
	b=CQopPuU3AdYl2LqSGzDjjai3LKmS7YNmQDXWmFrAnBVf8zHW//he9ZbZb0gDcfgMFxmLyU
	p48VB+euebaEHuCw==
Date: Thu, 05 Mar 2026 10:31:40 +0100
Subject: [PATCH v3 4/8] module: Give MODULE_SIG_STRING a more descriptive
 name
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-module-signature-uapi-v3-4-92f45ea6028c@linutronix.de>
References: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
In-Reply-To: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
To: David Howells <dhowells@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772703098; l=4511;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lm2zdd1A7Pa39t7QGFEXw1w4jepGk8HgTJnI9lzo6So=;
 b=e3e9L+FWnQFwvrCqH7CB0rUMPbEx0o4jOqzW32qzQjv3wWsUhb+daaheCsbjc8rNrwP/T6+Ja
 EHncLNu0gGmArtq4Q6j42QGWBq3gNPrsqbigZ9tlEI/FKIKP6hd1GV8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Queue-Id: E6B1220EA12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8918-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The purpose of the constant it is not entirely clear from its name.

As this constant is going to be exposed in a UAPI header, give it a more
specific name for clarity. As all its users call it 'marker', use that
wording in the constant itself.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/kernel/machine_kexec_file.c | 4 ++--
 include/linux/module_signature.h      | 2 +-
 kernel/module/signing.c               | 4 ++--
 security/integrity/ima/ima_modsig.c   | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 667ee9279e23..6f0852d5a3a9 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -28,7 +28,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 #ifdef CONFIG_KEXEC_SIG
 int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
+	const unsigned long marker_len = sizeof(MODULE_SIGNATURE_MARKER) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
 	int ret;
@@ -40,7 +40,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	if (marker_len > kernel_len)
 		return -EKEYREJECTED;
 
-	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIG_STRING,
+	if (memcmp(kernel + kernel_len - marker_len, MODULE_SIGNATURE_MARKER,
 		   marker_len))
 		return -EKEYREJECTED;
 	kernel_len -= marker_len;
diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
index c3a05d4cfe67..915549c779dc 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 
 /* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
-#define MODULE_SIG_STRING "~Module signature appended~\n"
+#define MODULE_SIGNATURE_MARKER "~Module signature appended~\n"
 
 enum module_signature_type {
 	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..590ba29c85ab 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -70,7 +70,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 int module_sig_check(struct load_info *info, int flags)
 {
 	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const unsigned long markerlen = sizeof(MODULE_SIGNATURE_MARKER) - 1;
 	const char *reason;
 	const void *mod = info->hdr;
 	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
@@ -81,7 +81,7 @@ int module_sig_check(struct load_info *info, int flags)
 	 */
 	if (!mangled_module &&
 	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
+	    memcmp(mod + info->len - markerlen, MODULE_SIGNATURE_MARKER, markerlen) == 0) {
 		/* We truncate the module to discard the signature */
 		info->len -= markerlen;
 		err = mod_verify_sig(mod, info);
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 9aa92fd35a03..632c746fd81e 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -40,7 +40,7 @@ struct modsig {
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig)
 {
-	const size_t marker_len = strlen(MODULE_SIG_STRING);
+	const size_t marker_len = strlen(MODULE_SIGNATURE_MARKER);
 	const struct module_signature *sig;
 	struct modsig *hdr;
 	size_t sig_len;
@@ -51,7 +51,7 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		return -ENOENT;
 
 	p = buf + buf_len - marker_len;
-	if (memcmp(p, MODULE_SIG_STRING, marker_len))
+	if (memcmp(p, MODULE_SIGNATURE_MARKER, marker_len))
 		return -ENOENT;
 
 	buf_len -= marker_len;
@@ -105,7 +105,7 @@ void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 	 * Provide the file contents (minus the appended sig) so that the PKCS7
 	 * code can calculate the file hash.
 	 */
-	size -= modsig->raw_pkcs7_len + strlen(MODULE_SIG_STRING) +
+	size -= modsig->raw_pkcs7_len + strlen(MODULE_SIGNATURE_MARKER) +
 		sizeof(struct module_signature);
 	rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
 	if (rc)

-- 
2.53.0


