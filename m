Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE9197BD0
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgC3M1n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 08:27:43 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:51948 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgC3M1n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 08:27:43 -0400
Received: by mail-wm1-f52.google.com with SMTP id c187so19775809wme.1
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wTPUEfg8EFLeUayAPDbXe/gG8c6xjgU+vmG4tsqws7Q=;
        b=TS13/MKc5UMi8PtQivaaI7TAHNMXhWZT9EBqc6glA7z4i1Ysmf7UMZdYiv9//3cn38
         9dtO/cElZ1Fny2jHLw9hKyR/YVkOu0Z9RTYsOrpjS9BydSkR/vS/36g8wKAlULoRBrqt
         dnzO7rfIwjF5I6j4xDlK1YNI2c5i9I8lPgDjuG0V5fYp3/x/ap0Nsku1RYPLwdlvt7X2
         kR8bzOwHIZBF2CVjnl9run8gb+aatvQwKeUY/+pzzP3GmYjxMy8vstp3I9qMPVqIoBH+
         YxkQqdlOsz7/1+lKPp0IX5kO+GZ4VGctZamGn30YI0iv6Z+7ktZgiMn8j95rLWtis8pR
         v1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wTPUEfg8EFLeUayAPDbXe/gG8c6xjgU+vmG4tsqws7Q=;
        b=Iirzi3LYUg9TFOIoUFjHB+4ItdmF7tKmWNXZi0SWjM0EjsmHzDAuO9EI5mitYw/fEs
         G4DzS4sxyrJAsfSh99SW4jxN6T3f/6J/qiCfmY8g8Mh7Utus064jjUk8XtlHt607Y/Qo
         al7X8v+4rhhpKZzzs0Pz/01MkoQ63L+nn2P49cDWmsRRLE80fZi0Ncji58i1dDjfYJGo
         qr8G8cdQk/9sfh6c+pjR7hAj6nabJ4/HX9ycB71UGafN4h+iqj/EUJ2kw8nmiE5CHEoR
         ublfLrDwhRTJkqyoi7MSAkQ5rDjQcNFOKb4688dLYjCqGF1uYQJN1FGB7xG9gF4Tvq2e
         ojFQ==
X-Gm-Message-State: ANhLgQ2whPoMLJu88OHJ69NMK+b9Y+cwuLXf+CfG4CgdaXVK14ganddl
        u+88ZehacQfHKe5YPVBRb0RjhKET/Sk=
X-Google-Smtp-Source: ADFU+vsscHYDVh5QTFyLGSBZ/IVrrhI8C/R5FtLzpNYvqn5ue6YIoV/P5GLhkFF4jxb7sl9atg3Fdg==
X-Received: by 2002:a1c:196:: with SMTP id 144mr13231138wmb.100.1585571260575;
        Mon, 30 Mar 2020 05:27:40 -0700 (PDT)
Received: from kl ([87.71.129.31])
        by smtp.gmail.com with ESMTPSA id x206sm20873860wmg.17.2020.03.30.05.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:27:40 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:27:37 +0300
From:   Lev Olshvang <levonshe@gmail.com>
To:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>
Subject: [PATCH] integrity ima_policy : Select files by suffix
Message-ID: <20200330122434.GB28214@kl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lev Olshvang <levonshe@gmail.com>
Date: Fri, 27 Mar 2020 20:50:01 +0300
Reply-To:
Subject: [PATCH] integrity ima_policy : Select files by suffix

IMA policy rule allows to select files based on uid, gid, fsuid. etc.
One tremendously useful selector(IMHO) is the file suffix.

I think of systemd service files, configurution files, etc.

But the real goal of the patch is the ability to validate shell scripts.
Shell provides too many different ways to run the script:
input redirrection, pipe, command line parameters.

IMA police rule below will catch any execution of file with sh suffix :

appraise FILE_OPEN suffix=sh

Another interesting byproduct of this feature is that any file might be put under validation.
All that you need is just create hard link to this file and apply immutable attribute to the link.
Example
appraise FILE_OPEN suffix=ini
ln /etc/shadow /etc/shadow.ini
chattr -i /etc/shadow.ini

Signed-off-by: Lev Olshvang <levonshe@gmail.com>
---
 security/integrity/ima/ima_policy.c | 41 ++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 453427048999..e8c7a4016fc6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -35,6 +35,7 @@
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
+#define IMA_SUFFIX	0x0800

 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -45,6 +46,8 @@
 #define HASH		0x0100
 #define DONT_HASH	0x0200

+#define IMA_SUFFIX_LEN 4
+
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8))

@@ -82,6 +85,8 @@ struct ima_rule_entry {
 	char *fsname;
 	char *keyrings; /* Measure keys added to these keyrings */
 	struct ima_template_desc *template;
+	// In the first byte we encode length, then string itself
+	char suffix[IMA_SUFFIX_LEN+2];
 };

 /*
@@ -419,6 +424,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			    const char *keyring)
 {
 	int i;
+	u8 sfx_len;
+	u16 name_offset;
+	struct dentry *dentry;

 	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
 		if ((rule->flags & IMA_FUNC) && (rule->func == func)) {
@@ -443,6 +451,13 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_FSNAME)
 	    && strcmp(rule->fsname, inode->i_sb->s_type->name))
 		return false;
+	if (rule->flags & IMA_SUFFIX) {
+		dentry = container_of(inode->i_dentry.first, struct dentry, d_u.d_alias);
+		sfx_len = (u8)rule->suffix[0] - 1;
+		name_offset = (u16) strlen(dentry->d_name.name) - sfx_len;
+		if ((memcmp(rule->suffix + 1, dentry->d_name.name + name_offset, sfx_len) != 0))
+			return false;
+	}
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
@@ -822,6 +837,7 @@ enum {
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
 	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
+	Opt_suffix,
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
@@ -849,6 +865,7 @@ static const match_table_t policy_tokens = {
 	{Opt_fsmagic, "fsmagic=%s"},
 	{Opt_fsname, "fsname=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
+	{Opt_suffix, "suffix=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
 	{Opt_fowner_eq, "fowner=%s"},
@@ -991,7 +1008,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)

 			if (entry->action != UNKNOWN)
 				result = -EINVAL;
-
 			entry->action = DONT_MEASURE;
 			break;
 		case Opt_appraise:
@@ -1120,6 +1136,21 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			result = 0;
 			entry->flags |= IMA_FSNAME;
 			break;
+		case Opt_suffix:
+			ima_log_string(ab, "suffix", args[0].from);
+			result = strlen(args[0].from);
+			result++; // add '\0'
+			if (result > IMA_SUFFIX_LEN) {
+				result = -E2BIG;
+				break;
+			}
+
+			/* encode suffix len in the first byte */
+			entry->suffix[0] = (u8) result;
+			memcpy(entry->suffix + 1, args[0].from, result);
+			result = 0;
+			entry->flags |= IMA_SUFFIX;
+			break;
 		case Opt_keyrings:
 			ima_log_string(ab, "keyrings", args[0].from);

@@ -1526,6 +1557,10 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_printf(m, pt(Opt_fsmagic), tbuf);
 		seq_puts(m, " ");
 	}
+	if (entry->flags & IMA_SUFFIX) {
+		seq_printf(m, "suffix=%s", entry->suffix + 1);
+		seq_puts(m, " ");
+	}

 	if (entry->flags & IMA_FSNAME) {
 		snprintf(tbuf, sizeof(tbuf), "%s", entry->fsname);
@@ -1546,6 +1581,10 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}

+	if (entry->flags & IMA_SUFFIX) {
+		seq_printf(m, "suffix=%s", entry->suffix + 1);
+		seq_puts(m, " ");
+	}
 	if (entry->flags & IMA_FSUUID) {
 		seq_printf(m, "fsuuid=%pU", &entry->fsuuid);
 		seq_puts(m, " ");
--
2.17.1

