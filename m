Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C488C1CDB1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfENROR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 13:14:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60250 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfENROR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 13:14:17 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 24BF220A115B;
        Tue, 14 May 2019 10:14:16 -0700 (PDT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
From:   Lakshmi <nramas@linux.microsoft.com>
Subject: [PATCH 0/2] public key: IMA signer logging: Log public key of IMA
 Signature signer in IMA log
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>
Message-ID: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
Date:   Tue, 14 May 2019 10:14:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The motive behind this patch series is to measure the public key
of the IMA signature signer in the IMA log.

The IMA signature of the file, logged using ima-sig template, contains
the key identifier of the key that was used to generate the signature.
But outside the client machine this key id is not sufficient to
uniquely determine which key the signature corresponds to.
Providing the public key of the signer in the IMA log would
allow, for example, an attestation service to securely verify
if the key used to generate the IMA signature is a valid and
trusted one, and that the key has not been revoked or expired.

An attestation service would just need to maintain a list of
valid public keys and using the data from the IMA log can attest
the system files loaded on the client machine.

To achieve the above the patch series does the following:
   - Adds a new method in asymmetric_key_subtype to query
     the public key of the given key
   - Adds a new IMA template namely "ima-sigkey" to store\read
     the public key of the IMA signature signer. This template
     extends the existing template "ima-sig"

Lakshmi (2):
   add support for querying public key from a given key
   add a new template ima-sigkey to store/read the public, key of ima
     signature signer

  .../admin-guide/kernel-parameters.txt         |  2 +-
  Documentation/crypto/asymmetric-keys.txt      |  1 +
  Documentation/security/IMA-templates.rst      |  5 +-
  crypto/asymmetric_keys/public_key.c           |  7 +++
  crypto/asymmetric_keys/signature.c            | 24 +++++++++
  include/crypto/public_key.h                   |  1 +
  include/keys/asymmetric-subtype.h             |  3 ++
  security/integrity/digsig.c                   | 54 +++++++++++++++++--
  security/integrity/digsig_asymmetric.c        | 44 +++++++++++++++
  security/integrity/ima/Kconfig                |  3 ++
  security/integrity/ima/ima_template.c         |  3 ++
  security/integrity/ima/ima_template_lib.c     | 43 +++++++++++++++
  security/integrity/ima/ima_template_lib.h     |  4 ++
  security/integrity/integrity.h                | 29 +++++++++-
  14 files changed, 216 insertions(+), 7 deletions(-)

-- 
2.17.1
