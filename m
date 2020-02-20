Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8695166840
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2020 21:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgBTUW4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Feb 2020 15:22:56 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39509 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgBTUW4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Feb 2020 15:22:56 -0500
Received: by mail-il1-f194.google.com with SMTP id f70so24799857ill.6
        for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2020 12:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g43zi0Kc4rp1x+vu6qU/MJPQUkT5VTc1y7CjnMTKB/U=;
        b=DxaOa9H9LsXwmVeUcdQ9a2a4Lx+1AEoRQm+cxsk/FaZxVs1YQwqkXI7AjFdbvv9Kn+
         NJIunjk6QvzzWAgEXLi0++42eecdwfZQc5vl+YKwnu4NU/RHtKpkQFK9L6g2KuWt1hOW
         RCN0wLy6+dIBia15/uRLf1XwwS5HwEPEsywENq5mVi35JW3EC1srSI4tk4nswAUNhJ0j
         IfIz3NixVjRiC+eVbeDd7yY3yTFNTzgU2dn00nZzQrhEh3LpzzCwByHW4Ew0TzeYxpWD
         /BjTsQrfY14WfDsK+Hf7MFDzLwa2hSM25QlcmhN3OTlsLoPtFK4t9ukFJ2yLdMVR1UeS
         7lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g43zi0Kc4rp1x+vu6qU/MJPQUkT5VTc1y7CjnMTKB/U=;
        b=R2IUL20xEoIxwes/Co6zfD1dS+fJUxWZsHSIB6cbzr9JwDJj15DFJsg3zxQ6kdqIZ5
         tOhbCop7kzaT+LDwnk5Vy6PUK7I577/Z0VneyBDwy/LtILYbexcNUJ+LZjBkaECbEN9U
         vIn6GJWHBzZ2jdXqfKZOfhix1HwhF8EuAS3VBipGqj+poeKnAfjqw+AaWATDaXz1b0w1
         FlaEBPbzzJErjFDYpvkd2BSujvGG+25XvJ9Bk4TRU2NpOUD95Wg5fI7C0pduw2fxlAbz
         lfYh7S81Uhe+IxRR3BiWOxXo/EF4iynTWyzHg4A5nIOYAAja08QJwkk26eV6mm+3oWbr
         7RPw==
X-Gm-Message-State: APjAAAW3uuafJIInG4RXAbyjhEsmMxgvcfMYPbgTtX6V8Mge3+AlvVhQ
        x/RC/gGC8xsUgi00ALWTtqJ4mAR3zI3mtekxkkq5hQ==
X-Google-Smtp-Source: APXvYqyNuaplL0CRgFxpxvHvZUjqeUhgKd8v09MShHRL8DnQfTpresGrI6AdEogQfkeQ7PjxSJJZjicYnNlz2G89rVM=
X-Received: by 2002:a92:4a0a:: with SMTP id m10mr31992109ilf.84.1582230175748;
 Thu, 20 Feb 2020 12:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20200102215518.148051-1-matthewgarrett@google.com> <20200104053108.B393D2071A@mail.kernel.org>
In-Reply-To: <20200104053108.B393D2071A@mail.kernel.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 20 Feb 2020 12:22:44 -0800
Message-ID: <CACdnJutSTAK8JA_dD9Mo_sNaZxK5GbUxa=xx7xrysh9gPqQNtw@mail.gmail.com>
Subject: Re: [PATCH V2] tpm: Don't make log failures fatal
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 3, 2020 at 9:31 PM Sasha Levin <sashal@kernel.org> wrote:
>
> The bot has tested the following trees: v5.4.7, v5.3.18, v4.19.92, v4.14.=
161, v4.9.207, v4.4.207.
> v4.14.161: Failed to apply! Possible dependencies:
=E2=80=A6
> v4.9.207: Failed to apply! Possible dependencies:
=E2=80=A6
> v4.4.207: Failed to apply! Possible dependencies:
=E2=80=A6
> How should we proceed with this patch?

Ignoring these kernels should be fine.
