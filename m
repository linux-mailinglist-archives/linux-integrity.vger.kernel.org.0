Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD2471431
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhLKOQp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 09:16:45 -0500
Received: from meesny.iki.fi ([195.140.195.201]:46554 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhLKOQo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 09:16:44 -0500
Received: from localhost (91-154-92-131.elisa-laajakaista.fi [91.154.92.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sakkinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id C5FC62006A;
        Sat, 11 Dec 2021 16:16:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1639232197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWK2//QP16YYAKOvxB7SmjTHAav5DJvc4RhNrtLCNuY=;
        b=Yw+soqVk91mkjO+u9oCqsklsz0eDktVYaFrfkr1hqnFszFMmOBOil7PAnbzmZmhF61Y4zC
        Hf9quCusc7sPSwavjNIydFj+Can7txH9rW+4qryDiQWE2xGeDmuZFDxvR4OgfN8WDCoaUH
        UBO/myhsmwtcAp0ZSEX0/FDBLD4jOTA=
Message-ID: <a71b600f34f66d6eca5c50259529b3fc476880f6.camel@iki.fi>
Subject: Re: [PATCH v4 11/16] securityfs: Only use
 simple_pin_fs/simple_release_fs for init_user_ns
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Sat, 11 Dec 2021 16:16:36 +0200
In-Reply-To: <20211207202127.1508689-12-stefanb@linux.ibm.com>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
         <20211207202127.1508689-12-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1639232197; a=rsa-sha256; cv=none;
        b=iyX8mTLK1fK+TH/O0vL6Vp+OfWDoKwmG5zy3iecl9baP3uKwFTL5UzU9mxlm/oegva9tF0
        FJK5+NRzQYp5kyYKFj4u1/wMwBcnYh8y8RkgMYDnM0EtLghdDSkC/Gh8bPZ4ndtiQhxJis
        3mStMi4Qo/4pE4Y9WB+XG0Wk5sO/Ksk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1639232197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWK2//QP16YYAKOvxB7SmjTHAav5DJvc4RhNrtLCNuY=;
        b=h/q1QQqnQYufTz/VSWZnDEytTk3wNcSIu+XrCPAOj0t7g15p74589jP/8f37N8Kpx+0U4S
        I3/z3cGalEP781aR64ZgFoceBg9622fIqWCWIdjqCYSNZD8d2OdihswIuRwTuE7oB97RhC
        DirA8wMIIw/wyxDmXc1MnZlWBVdkh+w=
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-12-07 at 15:21 -0500, Stefan Berger wrote:
> To prepare for virtualization of SecurityFS, use simple_pin_fs and
> simpe_release_fs only when init_user_ns is active.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

What do you mean by virtualization, and how does this prepare
securityfs for it? The commit message should be way more verbose.

/Jarkko
