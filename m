Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C61A1A2276
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2020 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgDHNBq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Apr 2020 09:01:46 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:51325 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgDHNBq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Apr 2020 09:01:46 -0400
Received: by mail-wm1-f52.google.com with SMTP id z7so5048059wmk.1
        for <linux-integrity@vger.kernel.org>; Wed, 08 Apr 2020 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8l1aZdcpit5m5OIdWtAU9/DApi2eJFfd+OIGzCMkfE0=;
        b=nrvlsKQPqxdQKrZRMV3LfhATEeubTeuvYz8H4opYfgzZVnnZ0npgLJTuC+DfOypxKR
         foqcdJn6dxwss4/0iZMVfr56N2pIk2foKItvgkaN5v0Pu7OrOezuwu8nHmVnpV01qBkJ
         pCrfONKhYnWRa4TWJnhEHs7VUDv9yT/JVzMkiK6db1RivRG58OtRB7+aP0B4pR+RjZmC
         UxO2lvbEd77IX90dzFx0GkdGGpViuDgVvC89teaUE9XVMGcucQ/toCizjxICwVQIerGz
         fnUFEbPENvUHRLAEC6n7aakwv/eL3SKveO6NPsYY23RC6e94mQE5T5N6vKTHC05JGniV
         jMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8l1aZdcpit5m5OIdWtAU9/DApi2eJFfd+OIGzCMkfE0=;
        b=iiWHajhbNoMooq9Vfh/4+PC6vpMnwN24DYgYUhGO0hyHKgLsG7ThhDlQjbad8Xa80T
         gbradAzjtvQEBAmdn9Pl4wlJ0e4/1Y5Wrv8yNdFV+B7+GCtXgsnI/f3rdD+gwIi5YKEJ
         gAvT5Bkqy0I4btqdUy3vg1H9BmQBc03sDv0NSwci3jN6AHvdGYK0YCn2DtwwX1uI/tOi
         qVp4fg8dFXb983BUQdZltDXsUVgP9WsNJ896qrUrXiPnuhVJYKldlq3OTpyAWqKqGXmj
         R26+P+lBIdIAenr325+YhttyFqUo1StRw2ILw1bOVaNhkS/z69WehrsXN8/3o9JpkTZV
         GK0A==
X-Gm-Message-State: AGi0PubPAp5EvC/lNTj+5uQjHPKeniMuBBdeeqTDvknA2ucivHa92GaI
        aRHFWTtrQjWKbXc/Jos4ylMwmT9jJxnmBHI01mwy21OM
X-Google-Smtp-Source: APiQypJqayCJa/ndVUHGtC7IXQDSkK0nRiG5zXipY3SemdCrYRhPqMSP99VGScWgNC0+/T1mVth/eiuKluE+XlVKG+U=
X-Received: by 2002:a1c:f205:: with SMTP id s5mr4519594wmc.101.1586350903760;
 Wed, 08 Apr 2020 06:01:43 -0700 (PDT)
MIME-Version: 1.0
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Wed, 8 Apr 2020 16:01:31 +0300
Message-ID: <CAP22eLEgfrXW6i+S3bYq6NUHd9S-Wi85wcqU9-Ju1oU2uJe-Ag@mail.gmail.com>
Subject: [RFC] Use file change time instead of generation
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are file systems that do not support inode i_generaton.
Why ctime of inode can not be used instead?
