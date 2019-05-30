Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B772FA66
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2019 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfE3Kjm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 May 2019 06:39:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35120 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3Kjl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 May 2019 06:39:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so4635076lfg.2;
        Thu, 30 May 2019 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHCpjvHPHCTUoXV4uzyX5njNo72efca1yr68KRYC8bg=;
        b=FVy1pCkJxN8ik5JUfKxMFYGCbz6l5KZhl3rvJrvnkcC4ab8Mz69mrBzdEeNBj7t1Hb
         sM+IkP63UqFdIZEJCy2iplbX8NJG5krIXKJNcfaO+YJ8Po5XuKir/Gs+zOA9foy8CrXV
         kp6NEaT4GFYIL+C5TRoB/aDQ34etmGwEqv6I1u/RzTF+MQMT8tzRw8WBvj+qAlttYiy3
         dT9tDfZHjVjSiQ0bMs9Ikz4o9p+pzoiGVuwhirwIme2kAz9X9ilDgcKMC1UzfrWwS96V
         B5kNJu55eZYIEinjqgFklVBfEISIwEw18ZHdpjA8qjf1nlqKazhnn+7GyKQAgm2L/T5v
         hf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHCpjvHPHCTUoXV4uzyX5njNo72efca1yr68KRYC8bg=;
        b=LjwUJIkJFQKFVWsKvPr0711AyutY51tuk3O44Bc/zfRHPtorjKtZhscTY2za9cchtq
         JRyL5p15pjCqChC8REjYrnWujV5IDFlTMp2t9pikTORwWsERdD5ZzIDhzMqJSkR2kSGD
         +y3LLRuvqNuY5pNNmUBEys9D/hBOFA9D/Fnb92/d07dJndV+DQuJw87g0k63A4idcjl1
         6pzIedrbhX/YAN7iXSMdO3xAvmEHwBuB4cWMBL6BfEI3Ie/NsppcwgmWRFM2nj9LoDHR
         CZ0IX5BvhrN5znLRwEvTpeh7U4eWUlYGN/e2UaL0i7MC9ptavYH28+S2D3dCWmT9B+fB
         xWNQ==
X-Gm-Message-State: APjAAAXlRCTIjKdxc1spW10Nk0ARYpHSvY1OfY+g8Xig0yvhsJM2jGhJ
        Fvs4Y5BF23LCweJvYBZ7wdd4cx0Q7PDhMB89gBjyopyDIxg=
X-Google-Smtp-Source: APXvYqx3q2JHj1PQIAbTirMy5R0zA5Kyt90S0aW3nEMYsCc024jMOC+k1A5bKZwKyAVdXgJddqc5uN+w3QUU+6uasK0=
X-Received: by 2002:ac2:4286:: with SMTP id m6mr1799271lfh.150.1559212778387;
 Thu, 30 May 2019 03:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov> <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
 <1558530022.4347.11.camel@linux.ibm.com> <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
 <1558533420.4347.30.camel@linux.ibm.com> <1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov>
In-Reply-To: <1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 30 May 2019 13:39:27 +0300
Message-ID: <CAE=NcranYrvV5Xnu8656kyDVUUzCs=Tdy+fkeo5jwVhtF8=81Q@mail.gmail.com>
Subject: Re: sleep in selinux_audit_rule_init
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 22, 2019 at 6:27 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > Ok.  The question is then how should IMA handle missing domains/types.
> >   Just dropping IMA policy rules doesn't sound safe, nor does skipping
> > rules in case the domains/types are restored.
>
> You can just do what audit_dupe_lsm_field() does.  It effectively
> disables the rule upon the invalidation (which makes sense, since it can
> no longer match anything since nothing can have that domain/type) but
> retains the string value so it can later re-activate the rule if the
> domain/type becomes valid again later.

Finally got a moment to look into this. It looks to me there is
already a notifier? Could something like this work?

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..2203451862d4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -154,6 +154,8 @@ unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
+int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
+                         void *lsm_data);

 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_main.c
b/security/integrity/ima/ima_main.c
index 5749ec92516f..449502f5c3dc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -52,6 +52,10 @@ int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 static struct workqueue_struct *ima_update_wq;

+static struct notifier_block ima_lsm_policy_notifier = {
+       .notifier_call = ima_lsm_policy_change,
+};
+
 static int __init hash_setup(char *str)
 {
        struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -691,6 +695,10 @@ static int __init init_ima(void)
                error = ima_init();
        }

+       error = register_lsm_notifier(&ima_lsm_policy_notifier);
+       if (error)
+               pr_warn("Couldn't register LSM notifier, error %d\n", error);
+
        if (!error)
                ima_update_policy_flag();
        else
diff --git a/security/integrity/ima/ima_policy.c
b/security/integrity/ima/ima_policy.c
index e0cc323f948f..c3983d24279a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -252,8 +252,8 @@ __setup("ima_appraise_tcb", default_appraise_policy_setup);
 /*
  * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
  * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
- * the reloaded LSM policy.  We assume the rules still exist; and BUG_ON() if
- * they don't.
+ * the reloaded LSM policy.  Keep currently invalid fields around in case
+ * they become valid after a policy reload.
  */
 static void ima_lsm_update_rules(void)
 {
@@ -269,11 +269,23 @@ static void ima_lsm_update_rules(void)
                                                           Audit_equal,
                                                           entry->lsm[i].args_p,
                                                           &entry->lsm[i].rule);
-                       BUG_ON(!entry->lsm[i].rule);
+                       if (result == -EINVAL)
+                               pr_warn("ima: rule for LSM \'%d\' is invalid\n",
+                                       entry->lsm[i].type);
                }
        }
 }

+int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
+                         void *lsm_data)
+{
+       if (event != LSM_POLICY_CHANGE)
+               return NOTIFY_DONE;
+
+       ima_lsm_update_rules();
+       return NOTIFY_DONE;
+}
+
 /**
  * ima_match_rules - determine whether an inode matches the measure rule.
  * @rule: a pointer to a rule
@@ -327,11 +339,10 @@ static bool ima_match_rules(struct
ima_rule_entry *rule, struct inode *inode,
        for (i = 0; i < MAX_LSM_RULES; i++) {
                int rc = 0;
                u32 osid;
-               int retried = 0;

                if (!rule->lsm[i].rule)
                        continue;
-retry:
+
                switch (i) {
                case LSM_OBJ_USER:
                case LSM_OBJ_ROLE:
@@ -352,11 +363,6 @@ static bool ima_match_rules(struct ima_rule_entry
*rule, struct inode *inode,
                default:
                        break;
                }
-               if ((rc < 0) && (!retried)) {
-                       retried = 1;
-                       ima_lsm_update_rules();
-                       goto retry;
-               }
                if (!rc)
                        return false;
        }



--
Janne
