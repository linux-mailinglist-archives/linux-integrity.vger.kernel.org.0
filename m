Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887A6423F6
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfFLL2o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 07:28:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44782 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfFLL2o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 07:28:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so11785009lfm.11;
        Wed, 12 Jun 2019 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrcwL5rTg2GfI5vKUhnJW12tJvsV9k169bGdVahLiS0=;
        b=Noyrz8/XO96gC9BcT8T8ZOWHOGpCOeQJp6N7lwIaTnC3q/lRnCRUcbkQAH0eDZeWGR
         V2FINggzSTseFJD9cKbOblssOhJG/a1hdQ+/aa4SRgAfqFlW0Pw0MgSpnhiO09r0pSQ5
         kiyQD6ZREl8Ob4/vu5nMN1qgRPe2pgFJUKh0cfyH9uuzFEAKHjyXoGc0MYUu4Zy6vlRJ
         mWGyGeegoFbcizy1BMwNJpO0X/MxSAdp0AB95LLvPOTgEbAUYfhpWWciNpLnICZU2wVj
         uQnzwnGGAi35oYb0dcRuYUDs5hUNbsXYu2ljeIW3RUl8anLNoexCm+bcCtXnPyiNDy7C
         NEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrcwL5rTg2GfI5vKUhnJW12tJvsV9k169bGdVahLiS0=;
        b=sYvduETEtesu5GHo1pok93bYQaNxmQi1VEZ72pB3MGa2rM/9U8bBjWKeCm+LOqTIoi
         2/eGT/Vb3EqXLD15KweH3t99JYGPOMFnr3Q/HFN9Ql3K7Ho69Mv2dDGtSEK4G3S1XfLx
         NOkOzlkkq3ujrIOmDlPyiKFEq0FwcZt3s/TVYzKaXJtjmTrqDKQDp4aghElKb7zBkQsy
         +27L5Q6PjcmoL2gCDedROOzumjYy9R7j9AyaSZKc+oo0AAt7GABK40MhF365LBcuQZGB
         kcjjbTdBX3bp0NhwQAfQqKiRpVTuZ/tTv/g1kdk3pA2QlwxeiWOarFFp1DY3dEs3Du52
         Y/BQ==
X-Gm-Message-State: APjAAAXKanM02pVV2I0pNUcM4igHq3PEATceXxIr1/FnMTT5EuQdweah
        0+5kbaoqCcBY2csyWqMcLhvcj50pxXYZNPsu3J2Rgchku2/Mmw==
X-Google-Smtp-Source: APXvYqxJWaNbobYnzhCfEafyGc2TK8Zbey+O1DAPjYZ4H1tbB3g3/lDvWzR7qbbYbJ6OQ2DE2yLzq0cp7qfW8swB7Mc=
X-Received: by 2002:a19:8cc:: with SMTP id 195mr5745566lfi.150.1560338922043;
 Wed, 12 Jun 2019 04:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
In-Reply-To: <20190606112620.26488-1-roberto.sassu@huawei.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 12 Jun 2019 14:28:30 +0300
Message-ID: <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ima/evm fixes for v5.2
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@huawei.com,
        mjg59@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, silviu.vlasceanu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 6, 2019 at 3:27 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Previous versions included the patch 'ima: don't ignore INTEGRITY_UNKNOWN
> EVM status'. However, I realized that this patch cannot be accepted alone
> because IMA-Appraisal would deny access to new files created during the
> boot.

The early initialization logic seems to have been changing, the
original one as I have understood it:
- before initialization
  - allow reading anything without security.ima
  - deny reading anything with security.ima
  - allow all writes
- after initialization
  - deny reading|writing anything without security.ima
  - deny reading|writing anything invalid
  - allow everything else

The logic is pretty handy as it even creates additional layer of
security around the early initialization files as they become
unreadable after use.

Now, if we initialize the system with a random key like in your patch,
this logic is to change quite drastically? It sounds to me the
userland may actually break, all the userland initialization files in
the existing ima configurations that do not use digsigs would become
unreadable given that the random key is put in? Remember, those files
can be protected via other means (most commonly signed ramdisk).


--
Janne
