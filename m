Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B945E368AC
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 02:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFFAQh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 20:16:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35628 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFAQh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 20:16:37 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5B8DB20B7192;
        Wed,  5 Jun 2019 17:16:36 -0700 (PDT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Subject: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
Message-ID: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
Date:   Wed, 5 Jun 2019 17:16:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The motive behind this patch series is to measure the public key
of keys in BuiltIn_Trusted_Keys keyring to IMA log.

The kernel could be built with the config parameter
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY enabled.
If this is done only those "IMA Signer Keys" that are signed by a key in
the "BuiltIn Trusted Keys" or the "Secondary Trusted Keys" can be added
to the "IMA Keyring".

In other words, "IMA Signer Keys" are attested by the "Trusted Keys"
on the client machines if the above config parameter is enabled.

IMA will enumerate the keys in the Trusted Keys keyring, and measure
them in the IMA log. On file read, IMA will validate the signature of
the system files using "IMA Signer Key" present in "IMA Keyring".

An attestation service would receive the "Trusted Keys" from
a trusted source (which is different from the client machines it is
attesting). The service would compare the Trusted Keys reported by
the client with the list of known Trusted Keys. A client would be
marked trusted by the service if and only if the keys reported
by the client are all trusted.

Using the above approach the attestation service will be attesting
the "IMA Signer" while the clients attest the IMA Signature of
the system files. This enables the service to attest the client
machines by maintaining only a list of "Trusted Keys". These keys
change much less frequently than "IMA Signer Keys". It also frees
the service from having to maintain the "Hash of System Files"
which would change very frequently. This approach would significantly
reduce the maintenance cost of the service with respect to the data used
for attesting clients.

To achieve the above the patch series does the following:
   - Adds a new method in asymmetric_key_subtype to query
     the public key of the given key
   - Enumerate the keys in "BuiltIn Trusted Keys" and measure
     them to IMA log.

Lakshmi (2):
   Added a new interface method namely query_public_key to
     asymmetric_key_subtype interface
   Measure keys in BuiltIn Trusted Keys keyring

  Documentation/crypto/asymmetric-keys.txt |  1 +
  certs/system_keyring.c                   |  7 ++
  crypto/asymmetric_keys/public_key.c      |  7 ++
  crypto/asymmetric_keys/signature.c       | 24 +++++++
  include/crypto/public_key.h              |  1 +
  include/keys/asymmetric-subtype.h        |  3 +
  include/keys/system_keyring.h            |  9 +++
  include/linux/key.h                      | 32 +++++++++
  security/integrity/digsig.c              | 58 +++++++++++++++++
  security/integrity/ima/Kconfig           |  9 +++
  security/integrity/ima/ima_init.c        | 62 ++++++++++++++++++
  security/integrity/integrity.h           | 25 ++++++++
  security/keys/keyring.c                  | 82 ++++++++++++++++++++++++
  13 files changed, 320 insertions(+)

-- 
2.17.1

