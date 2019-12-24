Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2D12A2FB
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Dec 2019 16:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLXPf3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Dec 2019 10:35:29 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39988 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfLXPf3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Dec 2019 10:35:29 -0500
Received: by mail-qv1-f67.google.com with SMTP id dp13so7571823qvb.7;
        Tue, 24 Dec 2019 07:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=24Mou9rUEJOpcYmYKS0Hm/+2PJ8APwN2cqEy3AtA8oM=;
        b=Lnio4XvLe4Jy8BQW1CAkxzUqavo6W+k6TFl0+FA0Q33WAWTOLQI8ov1IAFnVyxL5tq
         AFNog7IaeeK54CVJME3kGDxLzWCs9TlX590QO6MGiwznpdAtIqQ04JmPxMC7y4uZKTEp
         3NHH0RyGaeiX6ZfSl6GhtmwMSlzR6sIzaTbUFGkzV4fs5DLGHOeiahNWQ7pkyIiO8YFX
         pDTGBDC+HHEt2xTilsnPC4x0g8WijHN4d5CbuGcP4WzykWFhkg57krXotZyhRz20MXdk
         8aKyHqVp8bSHD8KUDdasPijse2MoQCmAOSpK/me/7Xsu8IdzyEFvciWvwx9IZKtl57q6
         atdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=24Mou9rUEJOpcYmYKS0Hm/+2PJ8APwN2cqEy3AtA8oM=;
        b=NeecQjOY5VDIsP2TlLmVMGETXQaXPRc6zM0uLzGZH2kXH5TEjcalhnC7aTPw1eAqx5
         E4qPy9zUK2Ge67NkHH1+ldXrUF9PCqJ/29DGA38nT4g19EknBpmB/uq7Q10/wto1U3MV
         jVkZko6KOJ0FHAeIRLF/tsD9EHvKdXA7Hc23rw13x+3M+aqIrNBmDUfQNbAzRKbwH3kw
         ptcFljKMPKl8VJTpjmkChnNDJ3kLMWYM6yHdASOpvtV7+QAJxRjw1Jkt0aQ0gB76/Cug
         ab9xLWTATIM1rtOLSkLi9kQ5is4SFT16JqHmQ5miAnzEUF+nvXA1sZZHV1bhHyVr4NvN
         /RQg==
X-Gm-Message-State: APjAAAWsi+jYan/Dn4fxcV3BULH55qBefOJXuc/NF9N7TbM4i4t6b9Ij
        nAvrxE8nExtdQq+KoCUy5oE=
X-Google-Smtp-Source: APXvYqzbxxJxY0BT4hrLYTEkyPoRqSgjX3ZZrSZXSNxN9WfjJts0mH5/vQd/T6nEQuCdMtTBiH3lfQ==
X-Received: by 2002:a0c:e80e:: with SMTP id y14mr29392065qvn.139.1577201726654;
        Tue, 24 Dec 2019 07:35:26 -0800 (PST)
Received: from localhost.localdomain (pool-100-37-119-75.nycmny.fios.verizon.net. [100.37.119.75])
        by smtp.gmail.com with ESMTPSA id 65sm3689290qtf.95.2019.12.24.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 07:35:25 -0800 (PST)
Message-ID: <f2bc130034b6e1ca66c3f18dfa3a4fa68fcbc82a.camel@gmail.com>
Subject: Re: [PATCH v1 - RFC] ima: export the measurement list when needed
From:   david.safford@gmail.com
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, monty.wiseman@ge.com
Date:   Tue, 24 Dec 2019 10:35:24 -0500
In-Reply-To: <CAE=NcrZUyLe1Ftk5wOuEMJBPnw+DBx9LACbk1JPJcpg8VdDiJQ@mail.gmail.com>
References: <20191220074929.8191-1-janne.karhunen@gmail.com>
         <1576850665.5241.52.camel@linux.ibm.com>
         <CAE=NcrZUyLe1Ftk5wOuEMJBPnw+DBx9LACbk1JPJcpg8VdDiJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-12-21 at 12:41 +0200, Janne Karhunen wrote:
> On Fri, Dec 20, 2019 at 4:04 PM Mimi Zohar <zohar@linux.ibm.com>
> wrote:
> 
> > Should the kernel be involved in writing the IMA measurement list
> > to a
> > file or, as Dave suggested, this should be delegated to a userspace
> > application?
> 
> That is a good question. I went this way as it did not feel right to
> me that the kernel would depend on periodic, reliable userspace
> functionality to stay running (we would have a circular dependency).
> The thing is, once the kernel starts to run low on memory, it may
> kill
> that periodic daemon flushing the data for reasons unrelated to IMA.
> 

I'm happy with either way (kernel writing, or userspace reading) the
data, but with the v1 patch, there is no way for userspace to force
that the list be flushed - it only flushes on full. I think it is 
important for userspace to be able to trigger a flush, such as just
prior to a kexec, or prior to an attestation. 

Perhaps you could simply remove the length test in ima_export_list(),
and export anytime the filename is provided? This could simplify
attestation clients, which could ask for different files each time
(list.1, list.2...), for automatic log maintenance. Since the template
format does not have sequence numbers, this would also help keep
track which records have already been seen.

dave


