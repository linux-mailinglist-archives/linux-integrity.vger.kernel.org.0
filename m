Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C31043EC
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2019 20:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfKTTHh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Nov 2019 14:07:37 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42040 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfKTTHg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Nov 2019 14:07:36 -0500
Received: by mail-wr1-f53.google.com with SMTP id a15so1201634wrf.9
        for <linux-integrity@vger.kernel.org>; Wed, 20 Nov 2019 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JptNQ6so/9L3uvOwNdnkFnNevzjTCJ/2Jz7F6P16UNE=;
        b=qOUjCaN15nQVAnYGAh5k9ZqCFiXXstdrjDiKyGteGmlvBopXrHMFq/g8mhjZGr383h
         Q6pOvDrOPY4TreQR2ybtaeIJ8NdFXS0YJ/L3qQGGiiLhcS4SqqAsap1VKP0smsLlQ0jD
         gbi0zUHvBM/46715o1mULRyRDUo1LLjEWpUFSSFj6fgqjBn6FqVP+AnTVQhcTMQGTOoU
         KwipHPcqSlhaemuwCoDVh9BudZgpoiDQHumCoQWigpujFgPOg1WP7S1crvRQZkm6x9bK
         vVo5iSCfF2ABovm0am2rmA6wrIOdrVMuChZROHVo34Po0xfrSYcumC8nSuMv3W8Okc03
         zU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JptNQ6so/9L3uvOwNdnkFnNevzjTCJ/2Jz7F6P16UNE=;
        b=LRI8Z1YwPeqsfaIfRaYJpZvlS/oeYYH7VRmx7+JDGWuFcQx/Wxwp8z/s8r73gG37Ll
         f/rXsr3aXA138cHNeVi95My5oj0dbZ0cZ5WsIlMcI0izv27vm/ZXlNzuzEYEbM/L8LpP
         JwClYmDP9dHX2r2/PABOsFwOKTOgFLxAZnh3iGGSm2RN6CTeWNHIQmB6Z32Fc/PjLlEW
         5BDVJ1QKWkhn0yXZe3pZju+xzDKvZUsov1/e9fU4M4XD4uAC/Q+OrG/WJ9qNlA51D47N
         3ZYJD9WeKazyD48vhFOfPPJRuzcd0I7kN2DKa9umbfB4D1f9lbVm+sKJlwU50pNNNKIe
         U2zQ==
X-Gm-Message-State: APjAAAXn4ajoPcFPUi/2DE7YwAgxy+fKcIfAPaIoT7CKF2Q072CDKTHm
        KiI/+R9iVVBGQY2BillHgy225GDHfOuD4VJwEQpeapUE
X-Google-Smtp-Source: APXvYqwczSTK37uxfe+x5BVr8efL1vIoez0/LAo+azzf4fk72xtP2hVY+kix5ZZR8VAZymV9EJCHy8EEAznn8a+Nn40=
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr5683592wrs.226.1574276854963;
 Wed, 20 Nov 2019 11:07:34 -0800 (PST)
MIME-Version: 1.0
From:   Pouneh Aghababazadeh <paghababazadeh@gmail.com>
Date:   Wed, 20 Nov 2019 11:07:23 -0800
Message-ID: <CAO0y-hs8PbhF5rLuvEpaQKcp21DfXnpPrS-ym_eXhwETO+q+OQ@mail.gmail.com>
Subject: Question about creating EVM key
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

I'm trying to experiment with user keys in EVM per the instructions
here: https://sourceforge.net/p/linux-ima/wiki/Home/#creating-trusted-and-evm-encrypted-keys
(the second block, for systems without TPM/don't have TPM ownership).

However, I'm getting the following error. Can you help me with this?

$ su -c 'keyctl pipe `keyctl search @u user kmk-user` > /etc/keys/kmk-user.blob'
Password:
keyctl_read_alloc: Permission denied

Thanks,
Pouneh
