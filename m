Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A0B4784
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2019 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbfIQGaq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Sep 2019 02:30:46 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46225 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfIQGaq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Sep 2019 02:30:46 -0400
Received: by mail-lf1-f46.google.com with SMTP id t8so1844241lfc.13
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXCHQuhCHet0c7anifz9tn4COPe2lCe/Ze06n0FCKKA=;
        b=Y7/7HLE6tpu+NW42uSI467T5liRsQhcznS9mbFq6+OfRahVm3Ka1d5XPfYLVPkscPS
         n0HCsNoQaSHhoJmN3YhOy+gT6LYQE+R6UqDbWtXdzi3XHLJr9Sc74nxYtpY5t/seIdSd
         Yx0Q18T+T3exHx0RlnPF0mFz2i3lgZno+oejRWDhpaKbO0fMYW2DOcBQRx3lL3N+B+0U
         J9DY7R5KhdLe27XBE/fgZx6shPXXocXwthzt3kQh+vPVeKD5N45y7vnlxogOxrIbO9Wf
         ZAvh51k0gdL4200Mgp66u2yBTlqmAym9cvmmVgoPVB0kMe4bcSj/wYK4NuF9OAY+wckJ
         LqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXCHQuhCHet0c7anifz9tn4COPe2lCe/Ze06n0FCKKA=;
        b=U5R7PG8IZKXMpI+go6BtPZoSwUDP2J2SLdqc2toYw9m+/+TdZcEyXck0CQNiLro4BH
         JoAJSzgI7Vqrc/l5PhxBPCKhchxaVc4NT/WqD0SrdCEg6RYVQjb3FdwwbRaDDFYddwEH
         uEpgusvK6J5mg7oiXPjMeFYsDaDGNdQUXLtnaemc2u6/C5glSZykSpRB8Jg5/4dbnYtb
         DTcy+b3L/uVnX65RGubhNXWDjtCFVDFdsRVebWcGCavtd5wORe6KSFpQvyqfXnE+SZv2
         aw+iqkCL+LVPBEgl7s0GsptvEMcNlgBiplrvd1xOShZ08K4g8WZRVJ3ZbH7JKzktxWBT
         /5Lw==
X-Gm-Message-State: APjAAAXnHBDe+nseORFZp1k4w86pHZZ5S1ToL46BAChU8YDzqgRvuTkw
        YYOQ33x6l9EifK7StxXiHK3/Py7U9EgK0vcwxRo=
X-Google-Smtp-Source: APXvYqyHEPcPdnKYzqH0JuzMCLJjGrtWSoHNajFcznqO/FAa6n7Y3miCAU+bcCS5NlOxd7HvIxXSweHJffLOhqi6Kgo=
X-Received: by 2002:a19:f24d:: with SMTP id d13mr1111230lfk.127.1568701843686;
 Mon, 16 Sep 2019 23:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com> <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
In-Reply-To: <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 17 Sep 2019 09:30:31 +0300
Message-ID: <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
Subject: Re: IMA on remote file systems
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-integrity@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 16, 2019 at 5:47 PM Chuck Lever <chuck.lever@oracle.com> wrote:

> >> My thought was to use an ephemeral Merkle tree for NFS (and
> >> possibly other remote filesystems, like FUSE, until these
> >> filesystems support durable per-file Merkle trees). A tree would
> >> be constructed when the client measures a file, but it would not
> >> saved to the filesystem. Instead of a hash of the file's contents,
> >> the tree's root signature is stored as the IMA metadata.
> >
> > So the attack you are trying to guard against is that the pages that
> > were evicted once and that are read back could still be integrity
> > verified?
>
> Yes, the idea would be to provide a generic mechanism for constructing
> ephemeral trees such that it can be used for the purpose you describe
> on behalf of file systems besides NFS; eg. FUSE, or other remote file
> systems such as SMB.

I might be wrong, but handling this properly would be good for the
core IMA as well. Take an example of a memory mapped database file:
this file will have generic write access for a group of processes.
Now, if the attacker can create memory pressure on the host, we might
eventually end up freeing pages from this particular file. Once this
happens the attacker is free to modify the pages on the disk and they
will all get eventually loaded back into the memory without no-one
noticing.

Could the fs-verity be plugged in as a measurement mechanism in the
IMA? So rather than calling a hash function, call verity to measure
and add new set of IMA hooks to report violations that arise after
execution? IMA policy logic and functionality would be pretty much
unchanged.


--
Janne
