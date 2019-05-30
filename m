Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95202FB91
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2019 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE3MaI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 May 2019 08:30:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40212 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfE3MaI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 May 2019 08:30:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id a9so3462728lff.7
        for <linux-integrity@vger.kernel.org>; Thu, 30 May 2019 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJgIMd1+iVdwEIDSKQuTybn4oWcmwW1Grc5lK2SgNVY=;
        b=J+lU0EP6MEIlCJNgwfs4FvuL91A2L+F6H8JW2g2IOONVCxDoi15ZDtpfs2zJk3174D
         QTSW76pvTrwhZrDnZcCe6Y82L//3QxvoAE2NfE6enQPPMJLNP0kp+traTLa1ZmC7HXmM
         Is+HO3XFBvtizEv7KrOc+7W8iTB70+AjndjluyrWQvAlYtJhBslBPQ27SPdwBYiJUliM
         AgJxPgCgOdnbNYulac/qiwUJuabnYQeg2YFT6BUcfKWrLUfTVhWM2nILJqlX6Qiar6zi
         iP9HxTecqlUfqQT10BcQPRyMX0ZOb8vRTCcuIutnTAWeS0SjwWkbE3+YY41x1JrBK8fx
         dkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJgIMd1+iVdwEIDSKQuTybn4oWcmwW1Grc5lK2SgNVY=;
        b=C/0mRIsZ/PwYgQDJgBI6K0VVfvVE3oBybydgcDtihjC0fayJ1Ztziuun+yIBwivxj7
         YYM0hkcRuAEt5M4gYpLTp6/A32ujmyY3ZckV0Eil0Qx6/QkwHeLYfETe/qsUVW4rmy5U
         DMwgdbLXCAk3rOmljuHjuErNUK0J4dZvJ9jbmQJrgfs0prkCe+cEnLX+EindJwPHA4aS
         mqE207MClqBf1KkVFS0fKGGDZlM8cdhva+sX4XPA4PfZiYA/9C/UNC9qnGVk15ZfdEoM
         VvgSQJ69FUXbt7bcjO4j5fRM/1CUIEi23RYicCgizVpI4WBCFhlfjCA2agFKqJ7jzfc1
         IkCg==
X-Gm-Message-State: APjAAAWa+M34CMPqHXGGak5D+gRg1LAq8LcMPsQngQqGXWcHloyzUPrM
        pDUlcQlsnTfgHIokP5SiSvhhAlWz52VMOqVGdtzmA+8=
X-Google-Smtp-Source: APXvYqy/sOXM7anQ5eciKRrpmyBZzjsr30O92zxwR2cCMgpH+K8ykW63T7R1qNBPl6yzZHzgHUEG0cDkhd1/+hfRt3I=
X-Received: by 2002:ac2:4111:: with SMTP id b17mr1772587lfi.31.1559219406331;
 Thu, 30 May 2019 05:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov> <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
 <1558530022.4347.11.camel@linux.ibm.com> <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
 <1558533420.4347.30.camel@linux.ibm.com> <1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov>
 <CAE=NcranYrvV5Xnu8656kyDVUUzCs=Tdy+fkeo5jwVhtF8=81Q@mail.gmail.com> <a39cedd1-a932-3140-bf11-ef4e3a88e254@tycho.nsa.gov>
In-Reply-To: <a39cedd1-a932-3140-bf11-ef4e3a88e254@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 May 2019 08:29:54 -0400
Message-ID: <CAHC9VhS=GsEVUmxtiV64o8G6i2nJpkzxzpyTADgN-vhV8pzZbg@mail.gmail.com>
Subject: Re: sleep in selinux_audit_rule_init
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Jurgens <danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 30, 2019 at 8:07 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> ... And lastly, it looks like lsm
> notifiers are atomic notifiers (not clear to me why) so you can't block
> in the callback, thereby requiring scheduling the work as is done in
> infiniband.  I'm not sure though why we can't make the lsm notifiers
> blocking notifiers.  The only callers of call_lsm_notifier() are
> sel_write_enforce() and selinux_lsm_notifier_avc_callback(), called from
> avc_ss_reset(), called from sel_write_enforce(), security_load_policy()
> and security_set_bools(), all outside of locks and in process context
> AFAICS.

Off the top of my head I don't recall why the atomic notifiers were
chosen over the blocking notifiers; it may simply be an artifact of an
interim patch that was changed.  Regardless, I have no problem if we
switch to using blocking notifiers.  However, if we are changing it
now it might be a good idea to also add a "block"/"blocking" somewhere
in the lsm_notifier functions' name to make the change obvious and to
help make it easier if we ever need to add atomic notifier support in
the future.

-- 
paul moore
www.paul-moore.com
