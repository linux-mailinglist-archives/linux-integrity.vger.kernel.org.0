Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C507730D48
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2019 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaLXB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 May 2019 07:23:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44847 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfEaLXA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 May 2019 07:23:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so9197252ljl.11;
        Fri, 31 May 2019 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DGgPIITBMNeYMKgLN+cBlEXT28ejYtk/5MZ8W8LCmQ=;
        b=MJ2jpTd8rWK9Vcjv+xl24mgdz1GSu1BqxIQUjnAuAINxXMRNVquTXhJChGmXBIHeR9
         HWkoWxr1K9guYXw4KpW6Uq9fIYu2NOpL6GdX1NVYL/pU1XMe06RQZPEx8oeAZ2D5ylbI
         s8VEgSgVKJaI+DoT4s+kTZyECayk3SOYhKV9FE1HVOI16HZKW4/RJ3K4RjcNJk8JjiBb
         kYgyBFkjZfuL2Mkby4NEiKUSZsIhibBr58sh66gZh4ZKvix+UbRC/gyZsiSYKtR70/Ur
         qcc6nez1K+SJUVajVgGCYbar1Yu+lMMMDUMeG4TmAy+myMCBZQYE6Z2Nej1jFLoccXo3
         pOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DGgPIITBMNeYMKgLN+cBlEXT28ejYtk/5MZ8W8LCmQ=;
        b=cFOLwxX3/vDMHzvwSzsQbvymvcy8DrI2/H2y0xdT0tPFQmXCalVH1RJa3FxlDqPAiK
         ydfraU6a1QEcUu3KWYVJzzWEir4Ns2nVf0acrg+OJ4b/n0QMRFQACXq4WvODJyojI35y
         txc0y+zfq+mmw6T4hHoEyF0XTRsODN5yzYbOMUa99bX/1sD30gTug0eL3wQTILRDaNj6
         W+O7VCwEeyrW3neHN/yMdSFR6heKPpaTXxtwGbTwSOkhf6len4ECp7B0KAShsGmCkYRt
         387V/Giwjjt3sM0eAvyUVmhg4KpmS8WGGciYA0rzeEnYMcEngJz9WT4uZTmdPo3GYZgy
         jWaw==
X-Gm-Message-State: APjAAAVIOAER25X3c94j6DHsdtSOhryc4uPxS4X8xvEtTJ7acrW91rJP
        Ovbakm02jVQJSaIWeeXCtIFlIq1pMzbBWKqI7f7pmIIqi/WsYw==
X-Google-Smtp-Source: APXvYqye90OtQ1rpB4a3hCP9d6GM2QPRa93PDkJsgp9cWJ3/8vK5YaxAxG2c343xYsdzxysQxmAR2WXh08T3cDOJQ14=
X-Received: by 2002:a2e:9cd5:: with SMTP id g21mr4901152ljj.39.1559301778321;
 Fri, 31 May 2019 04:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov> <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
 <1558530022.4347.11.camel@linux.ibm.com> <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
 <1558533420.4347.30.camel@linux.ibm.com> <1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov>
 <CAE=NcranYrvV5Xnu8656kyDVUUzCs=Tdy+fkeo5jwVhtF8=81Q@mail.gmail.com>
 <a39cedd1-a932-3140-bf11-ef4e3a88e254@tycho.nsa.gov> <CAE=NcrYV_x6dKbVvO+EDZNKMuEqVhyMKrdEjuUJXqfcYVeiXBA@mail.gmail.com>
 <54d804d0-25a6-2f5c-8fc9-0c671e34b8eb@tycho.nsa.gov>
In-Reply-To: <54d804d0-25a6-2f5c-8fc9-0c671e34b8eb@tycho.nsa.gov>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Fri, 31 May 2019 14:22:46 +0300
Message-ID: <CAE=Ncrb7wxhYt-yGSTKwehymEZ6_jaNbWSgPnxxRFXwY5q6_mg@mail.gmail.com>
Subject: Re: sleep in selinux_audit_rule_init
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Jurgens <danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 30, 2019 at 5:17 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> >>   Both of those issues also exist prior to your
> >> patch but you aren't fixing them here. And lastly, it looks like lsm
> >> notifiers are atomic notifiers (not clear to me why) so you can't block
> >> in the callback, thereby requiring scheduling the work as is done in
> >> infiniband.
> >
> > Great catch, thank you. That's an easy fix if no-one objects pushing
> > these through the system-wq for example.
>
> I think you can switch the lsm notifier over to using blocking notifiers
> instead; there seems to be no valid reason for making it atomic.

Further drafting. I certainly feel uneasy with the rcu update side of
it, but the string is not used in the matching so.. ?


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
index e0cc323f948f..6776dc2b9664 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -252,12 +252,14 @@ __setup("ima_appraise_tcb",
default_appraise_policy_setup);
 /*
  * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
  * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
- * the reloaded LSM policy.  We assume the rules still exist; and BUG_ON() if
- * they don't.
+ * the reloaded LSM policy.
  */
 static void ima_lsm_update_rules(void)
 {
        struct ima_rule_entry *entry;
+       void *rule_new;
+       char *lsm_new;
+       char *lsm_old;
        int result;
        int i;
@@ -265,13 +267,37 @@ static void ima_lsm_update_rules(void)
                for (i = 0; i < MAX_LSM_RULES; i++) {
                        if (!entry->lsm[i].rule)
                                continue;
+
+                       lsm_old = entry->lsm[i].args_p;
+                       lsm_new = kstrdup(lsm_old, GFP_KERNEL);
+                       if (unlikely(!lsm_new))
+                               return;
+
                        result = security_filter_rule_init(entry->lsm[i].type,
                                                           Audit_equal,
-                                                          entry->lsm[i].args_p,
-                                                          &entry->lsm[i].rule);
-                       BUG_ON(!entry->lsm[i].rule);
-               }
-       }
+                                                          lsm_new,
+                                                          &rule_new);
+                       if (result == -EINVAL)
+                               pr_warn("ima: rule for LSM \'%d\' is invalid\n",
+                                       entry->lsm[i].type);
+
+                       entry->lsm[i].rule = rule_new;
+                       entry->lsm[i].args_p = lsm_new;
+                       synchronize_rcu();
+
+                       kfree(lsm_old);
+                }
+        }
+}
+
+int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
+                         void *lsm_data)
+{
+       if (event != LSM_POLICY_CHANGE)
+               return NOTIFY_DONE;
+
+       ima_lsm_update_rules();
+       return NOTIFY_OK;
 }

 /**
@@ -327,11 +353,10 @@ static bool ima_match_rules(struct
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
@@ -352,11 +377,6 @@ static bool ima_match_rules(struct ima_rule_entry
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
diff --git a/security/security.c b/security/security.c
index 23cbb1a295a3..c5e69ce81521 100644
--- a/security/security.c
+++ b/security/security.c
@@ -39,7 +39,7 @@
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)

 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
-static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+static BLOCKING_NOTIFIER_HEAD(lsm_notifier_chain);

 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
@@ -432,19 +432,19 @@ void __init security_add_hooks(struct
security_hook_list *hooks, int count,

 int call_lsm_notifier(enum lsm_event event, void *data)
 {
-       return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
+       return blocking_notifier_call_chain(&lsm_notifier_chain, event, data);
 }
 EXPORT_SYMBOL(call_lsm_notifier);

 int register_lsm_notifier(struct notifier_block *nb)
 {
-       return atomic_notifier_chain_register(&lsm_notifier_chain, nb);
+       return blocking_notifier_chain_register(&lsm_notifier_chain, nb);
 }
 EXPORT_SYMBOL(register_lsm_notifier);

 int unregister_lsm_notifier(struct notifier_block *nb)
 {
-       return atomic_notifier_chain_unregister(&lsm_notifier_chain, nb);
+       return blocking_notifier_chain_unregister(&lsm_notifier_chain, nb);
 }
 EXPORT_SYMBOL(unregister_lsm_notifier);


--
Janne
