Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445C238D7B5
	for <lists+linux-integrity@lfdr.de>; Sun, 23 May 2021 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhEVWtz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 22 May 2021 18:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhEVWty (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 22 May 2021 18:49:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1CEE61205;
        Sat, 22 May 2021 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621723709;
        bh=2homtMocugXXwFijcrq3gkc1FOgAwfdZaeai9F4v6vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGcP/76CLDHC1sJhu0qC8+vb7k9s22yBUxVuH6mhHK1aMTtl6EKlvpYZ6mxhtM0nu
         F7h/OTmH4m/fZK2jjboplrzGJMWmusI+LA87r/at2yx54DApgsA76qQqHwmgvY4OAM
         2rfvMD5tmhgNIgtrP8EimlLZrSh5vltl2uXljnzZL6NKq1HnT2cEcum0hsPlYYP6UV
         FGBvG7jp+3a4meoSUwgttpioXh0LQmAcMRmbvnuGJi95/Yq7NR6P4JYA9U2Bjll87o
         tmrDcg47g8BPxd3r8mxgglK/obB++xMs2fZ/qTfGo/aE2Yqn4OXU9o7GaVPCQJ6jvg
         +D23tWdCr7BTQ==
Date:   Sun, 23 May 2021 01:48:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     openssl-tpm2-engine@groups.io, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/1] draft RFC for TPM key format
Message-ID: <YKmKOwKspmp5I/VT@kernel.org>
References: <20210522181548.8284-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522181548.8284-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, May 22, 2021 at 11:15:47AM -0700, James Bottomley wrote:
> Note: this is a patch for openssl_tpm2_engine, not the kernel.
> 
> This is the text of the draft RFC for comments (although patches to
> the xml would be preferred):
> 
> ======

Did not go through with an eyeglass but looks overally great!

> Network Working Group                                       J. Bottomley
> Internet-Draft                                              Linux Kernel
> Intended status: Informational                                  May 2021
> Expires: 23 November 2021
> 
> 
>                ASN.1 Specification for TPM 2.0 Key Files
>                       draft-bottomley-tpm-keys-00
> 
> Abstract
> 
>    This specification is designed ot be an extension to the ASN.1
>    (defined in [X.680]) specification of PKCS #1 [RFC8017] to define the
>    file format of private keys that need to be loaded into a TPM 2
>    device to operate.
> 
> Status of This Memo
> 
>    This Internet-Draft is submitted in full conformance with the
>    provisions of BCP 78 and BCP 79.
> 
>    Internet-Drafts are working documents of the Internet Engineering
>    Task Force (IETF).  Note that other groups may also distribute
>    working documents as Internet-Drafts.  The list of current Internet-
>    Drafts is at https://datatracker.ietf.org/drafts/current/.
> 
>    Internet-Drafts are draft documents valid for a maximum of six months
>    and may be updated, replaced, or obsoleted by other documents at any
>    time.  It is inappropriate to use Internet-Drafts as reference
>    material or to cite them other than as "work in progress."
> 
>    This Internet-Draft will expire on 2 November 2021.
> 
> Copyright Notice
> 
>    Copyright (c) 2021 IETF Trust and the persons identified as the
>    document authors.  All rights reserved.
> 
>    This document is subject to BCP 78 and the IETF Trust's Legal
>    Provisions Relating to IETF Documents (https://trustee.ietf.org/
>    license-info) in effect on the date of publication of this document.
>    Please review these documents carefully, as they describe your rights
>    and restrictions with respect to this document.  Code Components
>    extracted from this document must include Simplified BSD License text
>    as described in Section 4.e of the Trust Legal Provisions and are
>    provided without warranty as described in the Simplified BSD License.
> 
> 
> 
> 
> 
> Bottomley               Expires 23 November 2021                [Page 1]
> 
> Internet-Draft              TPM 2 Key Format                    May 2021
> 
> 
> Table of Contents
> 
>    1.  Introduction  . . . . . . . . . . . . . . . . . . . . . . . .   2
>    2.  Terminology . . . . . . . . . . . . . . . . . . . . . . . . .   2
>      2.1.  Notation  . . . . . . . . . . . . . . . . . . . . . . . .   2
>    3.  Key Representation  . . . . . . . . . . . . . . . . . . . . .   3
>      3.1.  TPMkey Syntax . . . . . . . . . . . . . . . . . . . . . .   3
>        3.1.1.  type  . . . . . . . . . . . . . . . . . . . . . . . .   4
>        3.1.2.  emptyAuth . . . . . . . . . . . . . . . . . . . . . .   4
>        3.1.3.  policy  . . . . . . . . . . . . . . . . . . . . . . .   4
>        3.1.4.  secret  . . . . . . . . . . . . . . . . . . . . . . .   4
>        3.1.5.  parent  . . . . . . . . . . . . . . . . . . . . . . .   5
>        3.1.6.  pubkey  . . . . . . . . . . . . . . . . . . . . . . .   5
>        3.1.7.  privkey . . . . . . . . . . . . . . . . . . . . . . .   5
>    4.  Key Policy Specification  . . . . . . . . . . . . . . . . . .   5
>      4.1.  TPMPolicy Syntax  . . . . . . . . . . . . . . . . . . . .   6
>        4.1.1.  CommandCode . . . . . . . . . . . . . . . . . . . . .   6
>        4.1.2.  CommandPolicy . . . . . . . . . . . . . . . . . . . .   6
>      4.2.  Policy Implementation Considerations  . . . . . . . . . .   6
>        4.2.1.  Authorization Policy  . . . . . . . . . . . . . . . .   6
>    5.  Normative References  . . . . . . . . . . . . . . . . . . . .   7
>    Author's Address  . . . . . . . . . . . . . . . . . . . . . . . .   7
> 
> 1.  Introduction
> 
>    The Security of private keys has long been a concern and the ability
>    of ubiquitous devices like TPMs has made it useful to use them for
>    secure private key storage.  With the advent of TPM 2.0, private key
>    storage inside the TPM (acting as a token which could be referred to
>    by PKCS #11) has been discouraged, and instead key files which are
>    loaded and evicted as necessary is the encouraged format.  This
>    standard defines an interoperable ASN.1 representation for such key
>    files, so that a key created by one tool should be loadable by a
>    different one.
> 
> 2.  Terminology
> 
>    The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
>    "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
>    document are to be interpreted as described in [RFC2119].
> 
> 2.1.  Notation
> 
>    ASN.1  Abstract Syntax Notatition defined in [X.680]
> 
>    DER  Distinguished Encoding Rules.  Basically a defined binary
>       representation for ASN.1
> 
> 
> 
> 
> Bottomley               Expires 23 November 2021                [Page 2]
> 
> Internet-Draft              TPM 2 Key Format                    May 2021
> 
> 
>    MSO  Most Significant Octet (the highest order byte of an integer)
> 
>    PEM  Privacy enhanced Electronic Mail.  An ASCII compatible
>       representation of DER
> 
>    TCG  Trusted Computing Group
> 
>    TPM  Trusted Platform Module
> 
> 3.  Key Representation
> 
>    All TPM 2.0 keys consist of two binary pieces, a public part, which
>    can be parsed according to the TPM specification for TPM2B_PUBLIC
>    [TPM2.0] and a private part, which is cryptographically sealed in
>    such a way as to be only readable on the TPM that created it.  The
>    purpose of this specification is to specify a format by which the
>    public and private pieces of a TPM key can be loaded.
> 
>    The design of the TPMkey ASN.1 format is that it should have a
>    distinguishing OID at the beginning so the DER/BER form of the key
>    can be easily recognized.  In PEM form, the key MUST have "-----BEGIN
>    TSS2 PRIVATE KEY-----" and "-----END TSS2 PRIVATE KEY-----" as the
>    PEM guards.  All additional information that may be needed to load
>    the key is specified as optional explicit elements, which can be
>    extended by later specifications, which is why the TPMkey is not
>    versioned.
> 
> 3.1.  TPMkey Syntax
> 
>     TPMKey ::= SEQUENCE {
>        type        OBJECT IDENTIFIER
>        emptyAuth   [0] EXPLICIT BOOLEAN OPTIONAL
>        policy      [1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL
>        secret      [2] EXPLICIT OCTET STRING OPTIONAL
>        parent      INTEGER
>        pubkey      OCTET STRING
>        privkey     OCTET STRING
>      }
> 
>    The fields of type TPMKey have the following meanings:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> Bottomley               Expires 23 November 2021                [Page 3]
> 
> Internet-Draft              TPM 2 Key Format                    May 2021
> 
> 
> 3.1.1.  type
> 
>    A unique OID specifying the key type.  This standard currently
>    defines three types of keys: a loadable key, specified by id-
>    loadablekey, (to be loaded with TPM2_Load), an importable key,
>    specified by id-importablekey, (to be loaded with TPM2_Import) and a
>    sealed data key, specified by id-sealedkey, (to be extracted with
>    TPM2_Unseal).  The TCG has reserved the following OID prefix for
>    this:
> 
>      id-tpmkey OBJECT IDENTIFIER ::=
>        {joint-iso-itu-t(2) international-organizations(23) 133 10}
> 
>    And the three key types are:
> 
>      id-loadablekey OBJECT IDENTIFIER ::=
>        {id-tpmkey 3}
> 
>      id-importablekey OBJECT IDENTIFIER ::=
>        {id-tpmkey 4}
> 
>      id-sealedkey OBJECT IDENTIFIER ::=
>        {id-tpmkey 5}
> 
> 3.1.2.  emptyAuth
> 
>    An implementation needs to know as it formulates the
>    TPM2_Load/Import/Unseal command whether it must also send down an
>    authorization, so this parameter gives that indication.  emptyAuth
>    MUST be true if authorization is NOT required and MUST BE either
>    false or absent if authorization is required.  Since this element has
>    three states (one representing true and two representing false) it is
>    RECOMMENDED that implementations emitting TPMkey representations use
>    absence of the tag to represent false.  However, implementations
>    reading TPMKey MUST be able to process all three possible states.
> 
> 3.1.3.  policy
> 
>    This MUST be present if the TPM key has a policy hash because it
>    describes to the implementation how to construct the policy.  The
>    forms of the policy statement are described in section Section 4.
> 
> 3.1.4.  secret
> 
>    This section describes the additional cryptographic secret used to
>    specify the outer wrapping of an importable key.  It MUST be present
>    for key type id-importablekey and MUST NOT be present for any other
>    key type.
> 
> 
> 
> Bottomley               Expires 23 November 2021                [Page 4]
> 
> Internet-Draft              TPM 2 Key Format                    May 2021
> 
> 
> 3.1.5.  parent
> 
>    This MUST be present for all keys and specifies the parent key.  The
>    parent key SHOULD be either a persistent handle (MSO 0x81) or a
>    permanent handle (MSO 0x40).  Since volatile handle numbering can
>    change unexpectedly depending on key load order, the parent SHOULD
>    NOT be a volatile handle (MSO 0x80).  The parent MAY NOT be any other
>    MSO.
> 
>    If a permanent handle (MSO 0x40) is specified then the implementation
>    MUST run TPM2_CreatePrimary on the handle using the TCG specified
>    Elliptic Curve template for the NIST P-256 curve and use the primary
>    key so generated as the parent.
> 
> 3.1.6.  pubkey
> 
>    This MUST be present and MUST correspond to the fully marshalled
>    TPM2B_PUBLIC structure of the TPM Key with the exception that the
>    leading U16 parameter specifying size MUST BE omitted (it is
>    redundant, since all ASN.1 structures are length specified).
> 
> 3.1.7.  privkey
> 
>    This MUST be present and MUST correspond to the fully marshalled
>    TPM2B_PRIVATE structure of the TPM Key with the exception that the
>    leading U16 parameter specifying size MUST BE omitted (it is
>    redundant, since all ASN.1 structures are length specified).
> 
> 4.  Key Policy Specification
> 
>    Policy is constructed on a TPM by executing a sequence of policy
>    statements.  This specification currently only defines a limited
>    subset of the allowed policy statements.  The policy is specified by
>    a hash, which the execution of the policy statements must reach in
>    order for the policy to be validated (See [TPM2.0] Part 1 for a
>    detailed description.
> 
>    The TPMPolicy ASN.1 MUST be a sequence of policy statements which
>    correspond exactly to TPM policy instructions in the order they
>    should be executed and additionally from which the ultimate policy
>    hash can be constructed.
> 
>    The current policy specification is strictly for AND based policy
>    only and may be extended at a later date with OR policy.  However,
>    the ASN.1 for policy is fomulated as CONS elements, leaving the
>    possibility of adding additional but optional elements for policy
>    statements which are not supported by this standard (such as
>    TPM2_PolicyAuthorize).
> 
> 
> 
> Bottomley               Expires 23 November 2021                [Page 5]
> 
> Internet-Draft              TPM 2 Key Format                    May 2021
> 
> 
> 4.1.  TPMPolicy Syntax
> 
>     TPMPolicy ::= SEQUENCE {
>        CommandCode   [0] EXPLICIT INTEGER
>        CommandPolicy [1] EXPLICIT OCTET STRING
>      }
> 
>    The Fields of type TPMPolicy have the following meanings:
> 
> 4.1.1.  CommandCode
> 
>    This is the integer representation of the TPM command code for the
>    policy statement.
> 
> 4.1.2.  CommandPolicy
> 
>    This is a binary string representing a fully marshalled, TPM ordered,
>    command body for the TPM policy command.  Therefore to send the
>    command, the implementation simply marshalls the command code and
>    appends this octet string as the body.
> 
>    Commands which have no body, such as TPM2_AuthVal, MUST be specified
>    as a zero length OCTET STRING
> 
> 4.2.  Policy Implementation Considerations
> 
>    The policy hash for AND based policies is constructed by extension of
>    the prior policy hash
> 
>      newHash = HASH ( oldHash || policyHash )
> 
>    where policyHash is usually simply the hash of the fully marshalled
>    policy command (including the CommandCode).  However, this isn't true
>    for TPM2_PolicyCounterTimer() so always consult the [TPM2.0]
>    specifications for how to construct the policyHash.
> 
> 4.2.1.  Authorization Policy
> 
>    When Authorization (Passing in a password) is required, the emptyAuth
>    parameter MUST be absent or set to false and additionally the
>    TPM_CC_PolicyAuthValue MUST be specified as the command code for one
>    entry in the TPMPolicy sequence.  However, the implementation MAY
>    choose to execute either TPM2_PolicyPassword for TPM_RS_PW or
>    TPM2_PolicyAuthValue for HMAC based authorization depending on
>    whether the command being authorized is using sessions or not.  If
>    the policy does not require an authorization then the emptyAuth
>    parameter MUST be set to true.
> 
> 
> 
> 
> Bottomley               Expires 23 November 2021                [Page 6]
> 
> Internet-Draft              TPM 2 Key Format                    May 2021
> 
> 
> 5.  Normative References
> 
>    [RFC2119]  Bradner, S., "Key words for use in RFCs to Indicate
>               Requirement Levels", BCP 14, RFC 2119,
>               DOI 10.17487/RFC2119, March 1997,
>               <https://www.rfc-editor.org/info/rfc2119>.
> 
>    [RFC8017]  Moriarty, K., Ed., Kaliski, B., Jonsson, J., and A. Rusch,
>               "PKCS #1: RSA Cryptography Specifications Version 2.2",
>               RFC 8017, DOI 10.17487/RFC8017, November 2016,
>               <https://www.rfc-editor.org/info/rfc8017>.
> 
>    [TPM2.0]   TCG, ., "TPM 2.0 Library Specification", 15 March 2013,
>               <https://trustedcomputinggroup.org/resource/tpm-library-
>               specification/>.
> 
>    [X.680]    ITU, "ITU-T Recommendation X.680, Information technology -
>               Abstract Syntax Notation One (ASN.1): Specification of
>               basic notation.", August 2015,
>               <https://www.itu.int/rec/T-REC-X.680-201508-I/en>.
> 
> Author's Address
> 
>    James E.J. Bottomley
>    Linux Kernel
>    United States of America
> 
>    Email: James.Bottomley@HansenPartnership.com
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> Bottomley               Expires 23 November 2021                [Page 7]
> 
> ======
> 
> James
> 
> ---
> 
> James Bottomley (1):
>   doc: add draft RFC for TPM Key format
> 
>  Makefile.am                       |   2 +-
>  configure.ac                      |   4 +-
>  doc/Makefile.am                   |  15 ++
>  doc/draft-bottomley-tpm2-keys.xml | 329 ++++++++++++++++++++++++++++++
>  4 files changed, 348 insertions(+), 2 deletions(-)
>  create mode 100644 doc/Makefile.am
>  create mode 100644 doc/draft-bottomley-tpm2-keys.xml
> 
> -- 
> 2.26.2
> 
> 

/Jarkko
