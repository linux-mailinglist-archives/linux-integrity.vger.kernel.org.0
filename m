Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6331288A3
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Dec 2019 11:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLUKle (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 21 Dec 2019 05:41:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34182 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfLUKle (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 Dec 2019 05:41:34 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so764625lfc.1;
        Sat, 21 Dec 2019 02:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jefykCaTxGKsMRjlGh4c7SNdLt41FlFZ9hLj4BueUtQ=;
        b=OJadrQuqaiOzSpCMguFftxKT7qdDxzNJ/gCAKG1wQ1Ny8KMIaUwi972ZZyvuc9Zw9o
         fY28dvLsFWki9G7zQWDxS+EF1I6R78wUfdBk+hghjOqmXHpn5Epe2BK/8ZOhOnfnRa9B
         FC0fg5J3YMB/oM+V1bQG4s7WtMzB/UPTFutIl30ZdOpyCAuJPFPX5Vpz2rhgDMeRwc1d
         8FzR2KI4msn7ZG6+i6xrHpAoqu6xq0105U68nwpbHFGAyXk0G912J3zq8Td1G/72deM+
         07id3wm+aX1nMgxbeQQjsx4p2BJm2TGEv0jjmxS/3RQCAQIvrOJuZw0wyZ8cvdwE/a3s
         krCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jefykCaTxGKsMRjlGh4c7SNdLt41FlFZ9hLj4BueUtQ=;
        b=PfbMw+NiGjxTI1SMgfhEh4aEJa4fs/3d/NWaj3ZQaSnckFPIn+/i91T50j611rfA8H
         CejLu+gA7RHIENvU3jOcU1ZpYPVQBagNMUuT69DMe7itDmDWMWn0V77jrGzKd1dOQb3a
         oHMxKb92HN46wfRQUAydkXPRbybKQTTcbPgUsnBhrGacRVFM2MYdtkMuch1yTErUzhS2
         bdzq3zwRlwBjZ0GJr5JUYf5qE6v2ybCZsp7VzY//rsfMZE8JvmuUbmhsSpmUd7rAkpq2
         ar7jjbcir1Y6w/DJw5QubtOD4utxGvpKlb5sN6VjtIpKEpzF1uViS9B/gAVLRh1M+WEA
         E8pA==
X-Gm-Message-State: APjAAAXrw+kuneF3it7cu8+454qChhSIMyxtbfBxEtKIJT/+5pAePrgX
        6kUjVVGuyan3qVj04VcVtleNGuyGdFOdapVpS6U=
X-Google-Smtp-Source: APXvYqwO0yPetzsQD++RdzuVF9NZp0Wc2ugAcm600amP6KFqoInrtnkgJfkaZPXbE790j8FyD6gR1GxYuymUtYZcuvM=
X-Received: by 2002:a19:c1c1:: with SMTP id r184mr11945566lff.128.1576924891568;
 Sat, 21 Dec 2019 02:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20191220074929.8191-1-janne.karhunen@gmail.com> <1576850665.5241.52.camel@linux.ibm.com>
In-Reply-To: <1576850665.5241.52.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Sat, 21 Dec 2019 12:41:20 +0200
Message-ID: <CAE=NcrZUyLe1Ftk5wOuEMJBPnw+DBx9LACbk1JPJcpg8VdDiJQ@mail.gmail.com>
Subject: Re: [PATCH v1 - RFC] ima: export the measurement list when needed
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 20, 2019 at 4:04 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> Should the kernel be involved in writing the IMA measurement list to a
> file or, as Dave suggested, this should be delegated to a userspace
> application?

That is a good question. I went this way as it did not feel right to
me that the kernel would depend on periodic, reliable userspace
functionality to stay running (we would have a circular dependency).
The thing is, once the kernel starts to run low on memory, it may kill
that periodic daemon flushing the data for reasons unrelated to IMA.


-- 
Janne
