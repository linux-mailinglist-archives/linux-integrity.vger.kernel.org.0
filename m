Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82DE38F58D
	for <lists+linux-integrity@lfdr.de>; Tue, 25 May 2021 00:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhEXWVn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 May 2021 18:21:43 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:34598 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhEXWVm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 May 2021 18:21:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 262B512802E3;
        Mon, 24 May 2021 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621894814;
        bh=JFxKvl54lo6wa9vIOI0JMMvdByaSQ/5Eu1FbsB6LPIs=;
        h=From:To:Subject:Date:Message-Id:From;
        b=fbwwf5y5Of0wmMRxM8KUZlIdjQ74DzX9H6UIWt1nLvYAOqY2FJs6qSZiCQwtMlZUR
         nOYeWp+bcTR+sWd+BJ+2qYc1p/NvNOefeI+lYW3svvvPIgfzQm59qsmQus5x9OvXA7
         sZvDAR1qGOAG6J2sTpjZCyAIXEa+v7HoKZ8ic6HQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rE5aR5mlXwa1; Mon, 24 May 2021 15:20:14 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 95DB5128029D;
        Mon, 24 May 2021 15:20:13 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     openssl-tpm2-engine@groups.io
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v2 0/1] draft RFC for TPM key format
Date:   Mon, 24 May 2021 15:20:10 -0700
Message-Id: <20210524222011.24313-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Note: this is a patch for openssl_tpm2_engine, not the kernel.

Changes for v2: Add security considerations, iana considerations and
implementation considerations sections and more detailed description
of importable keys.

This is the text of the draft RFC for comments (although patches to
the xml would be preferred):

======
Network Working Group                                       J. Bottomley
Internet-Draft                                              Linux Kernel
Intended status: Informational                                  May 2021
Expires: 25 November 2021


               ASN.1 Specification for TPM 2.0 Key Files
                      draft-bottomley-tpm-keys-00

Abstract

   This specification is designed to be an extension to the ASN.1
   (defined in [X.680]) specification of PKCS #1 [RFC8017] to define the
   file format of private keys that need to be loaded into a TPM 2
   device to operate.

Status of This Memo

   This Internet-Draft is submitted in full conformance with the
   provisions of BCP 78 and BCP 79.

   Internet-Drafts are working documents of the Internet Engineering
   Task Force (IETF).  Note that other groups may also distribute
   working documents as Internet-Drafts.  The list of current Internet-
   Drafts is at https://datatracker.ietf.org/drafts/current/.

   Internet-Drafts are draft documents valid for a maximum of six months
   and may be updated, replaced, or obsoleted by other documents at any
   time.  It is inappropriate to use Internet-Drafts as reference
   material or to cite them other than as "work in progress."

   This Internet-Draft will expire on 2 November 2021.

Copyright Notice

   Copyright (c) 2021 IETF Trust and the persons identified as the
   document authors.  All rights reserved.

   This document is subject to BCP 78 and the IETF Trust's Legal
   Provisions Relating to IETF Documents (https://trustee.ietf.org/
   license-info) in effect on the date of publication of this document.
   Please review these documents carefully, as they describe your rights
   and restrictions with respect to this document.  Code Components
   extracted from this document must include Simplified BSD License text
   as described in Section 4.e of the Trust Legal Provisions and are
   provided without warranty as described in the Simplified BSD License.





Bottomley               Expires 25 November 2021                [Page 1]

Internet-Draft              TPM 2 Key Format                    May 2021


Table of Contents

   1.  Introduction  . . . . . . . . . . . . . . . . . . . . . . . .   2
   2.  Terminology . . . . . . . . . . . . . . . . . . . . . . . . .   2
     2.1.  Notation  . . . . . . . . . . . . . . . . . . . . . . . .   3
   3.  Key Representation  . . . . . . . . . . . . . . . . . . . . .   3
     3.1.  TPMkey Syntax . . . . . . . . . . . . . . . . . . . . . .   3
       3.1.1.  type  . . . . . . . . . . . . . . . . . . . . . . . .   4
       3.1.2.  emptyAuth . . . . . . . . . . . . . . . . . . . . . .   4
       3.1.3.  policy  . . . . . . . . . . . . . . . . . . . . . . .   4
       3.1.4.  secret  . . . . . . . . . . . . . . . . . . . . . . .   4
       3.1.5.  parent  . . . . . . . . . . . . . . . . . . . . . . .   5
       3.1.6.  pubkey  . . . . . . . . . . . . . . . . . . . . . . .   5
       3.1.7.  privkey . . . . . . . . . . . . . . . . . . . . . . .   5
   4.  Key Policy Specification  . . . . . . . . . . . . . . . . . .   5
     4.1.  TPMPolicy Syntax  . . . . . . . . . . . . . . . . . . . .   6
       4.1.1.  CommandCode . . . . . . . . . . . . . . . . . . . . .   6
       4.1.2.  CommandPolicy . . . . . . . . . . . . . . . . . . . .   6
     4.2.  Policy Implementation Considerations  . . . . . . . . . .   6
       4.2.1.  Authorization Policy  . . . . . . . . . . . . . . . .   7
   5.  Implementation Considerations . . . . . . . . . . . . . . . .   7
   6.  Security Considerations . . . . . . . . . . . . . . . . . . .   7
   7.  IANA Considerations . . . . . . . . . . . . . . . . . . . . .   8
   8.  Comments on and Enhancements to this Document . . . . . . . .   8
   9.  References  . . . . . . . . . . . . . . . . . . . . . . . . .   9
     9.1.  Normative References  . . . . . . . . . . . . . . . . . .   9
     9.2.  Informative References  . . . . . . . . . . . . . . . . .   9
   Author's Address  . . . . . . . . . . . . . . . . . . . . . . . .  10

1.  Introduction

   The Security of private keys has long been a concern and the ability
   of ubiquitous devices like TPMs has made it useful to use them for
   secure private key storage.  With the advent of TPM 2.0, private key
   storage inside the TPM (acting as a token which could be referred to
   by PKCS #11) has been discouraged, and instead key files which are
   loaded and evicted as necessary is the encouraged format.  This
   standard defines an interoperable ASN.1 representation for such key
   files, so that a key created by one tool should be loadable by a
   different one.

2.  Terminology

   The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
   "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
   document are to be interpreted as described in [RFC2119].





Bottomley               Expires 25 November 2021                [Page 2]

Internet-Draft              TPM 2 Key Format                    May 2021


2.1.  Notation

   ASN.1  Abstract Syntax Notation defined in [X.680]

   DER  Distinguished Encoding Rules.  Basically a defined binary
      representation for ASN.1

   MSO  Most Significant Octet (the highest order byte of an integer)

   PEM  Privacy enhanced Electronic Mail.  An ASCII compatible
      representation of DER

   TCG  Trusted Computing Group

   TPM  Trusted Platform Module

3.  Key Representation

   All TPM 2.0 keys consist of two binary pieces, a public part, which
   can be parsed according to the TPM specification for TPM2B_PUBLIC
   [TPM2.0] and a private part, which is cryptographically sealed in
   such a way as to be only readable on the TPM that created it.  The
   purpose of this specification is to specify a format by which the
   public and private pieces of a TPM key can be loaded.

   The design of the TPMkey ASN.1 format is that it should have a
   distinguishing OID at the beginning so the DER form of the key can be
   easily recognized.  In PEM form, the key MUST have "-----BEGIN TSS2
   PRIVATE KEY-----" and "-----END TSS2 PRIVATE KEY-----" as the PEM
   guards.  All additional information that may be needed to load the
   key is specified as optional explicit elements, which can be extended
   by later specifications, which is why the TPMkey is not versioned.

3.1.  TPMkey Syntax

    TPMKey ::= SEQUENCE {
       type        OBJECT IDENTIFIER
       emptyAuth   [0] EXPLICIT BOOLEAN OPTIONAL
       policy      [1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL
       secret      [2] EXPLICIT OCTET STRING OPTIONAL
       parent      INTEGER
       pubkey      OCTET STRING
       privkey     OCTET STRING
     }

   The fields of type TPMKey have the following meanings:





Bottomley               Expires 25 November 2021                [Page 3]

Internet-Draft              TPM 2 Key Format                    May 2021


3.1.1.  type

   A unique OID specifying the key type.  This standard currently
   defines three types of keys: a loadable key, specified by id-
   loadablekey, (to be loaded with TPM2_Load), an importable key,
   specified by id-importablekey, (to be loaded with TPM2_Import) and a
   sealed data key, specified by id-sealedkey, (to be extracted with
   TPM2_Unseal).  The TCG has reserved the following OID prefix for
   this:

     id-tpmkey OBJECT IDENTIFIER ::=
       {joint-iso-itu-t(2) international-organizations(23) 133 10}

   And the three key types are:

     id-loadablekey OBJECT IDENTIFIER ::=
       {id-tpmkey 3}

     id-importablekey OBJECT IDENTIFIER ::=
       {id-tpmkey 4}

     id-sealedkey OBJECT IDENTIFIER ::=
       {id-tpmkey 5}

3.1.2.  emptyAuth

   An implementation needs to know as it formulates the
   TPM2_Load/Import/Unseal command whether it must also send down an
   authorization, so this parameter gives that indication.  emptyAuth
   MUST be true if authorization is NOT required and MUST BE either
   false or absent if authorization is required.  Since this element has
   three states (one representing true and two representing false) it is
   RECOMMENDED that implementations emitting TPMkey representations use
   absence of the tag to represent false.  However, implementations
   reading TPMKey MUST be able to process all three possible states.

3.1.3.  policy

   This MUST be present if the TPM key has a policy hash because it
   describes to the implementation how to construct the policy.  The
   forms of the policy statement are described in section Section 4.

3.1.4.  secret

   This section describes the additional cryptographic secret used to
   specify the outer wrapping of an importable key.  It MUST be present
   for key type id-importablekey and MUST NOT be present for any other
   key type.



Bottomley               Expires 25 November 2021                [Page 4]

Internet-Draft              TPM 2 Key Format                    May 2021


   Importable keys (designed to be processed by TPM2_Import) MUST have
   an unencrypted inner wrapper (symmetricAlg MUST be TPM_ALG_NULL and
   encryptionKey MUST be empty) and an outer wrapper encrypted to the
   parent key using inSymSeed.  The secret parameter is the fully
   marshalled TPM2B_ENCRYPTED_SECRET form of inSymSeed.

3.1.5.  parent

   This MUST be present for all keys and specifies the handle of the
   parent key.  The parent key SHOULD be either a persistent handle (MSO
   0x81) or a permanent handle (MSO 0x40).  Since volatile handle
   numbering can change unexpectedly depending on key load order, the
   parent SHOULD NOT be a volatile handle (MSO 0x80).  The parent MUST
   NOT have any other MSO.

   If a permanent handle (MSO 0x40) is specified then the implementation
   MUST run TPM2_CreatePrimary on the handle using the TCG specified
   Elliptic Curve template for the NIST P-256 curve and use the primary
   key so generated as the parent.

3.1.6.  pubkey

   This MUST be present and MUST correspond to the fully marshalled
   TPM2B_PUBLIC structure of the TPM Key.

3.1.7.  privkey

   This MUST be present and MUST correspond to the fully marshalled
   TPM2B_PRIVATE structure of the TPM Key.  For importable keys, this
   must be the duplicate parameter that would be input to TPM2_Import.

4.  Key Policy Specification

   Policy is constructed on a TPM by executing a sequence of policy
   statements.  This specification currently only defines a limited
   subset of the allowed policy statements.  The policy is specified by
   a hash, which the execution of the policy statements must reach in
   order for the policy to be validated (See [TPM2.0] Part 1 for a
   detailed description.

   The TPMPolicy ASN.1 MUST be a sequence of policy statements which
   correspond exactly to TPM policy instructions in the order they
   should be executed and additionally from which the ultimate policy
   hash can be constructed.

   The current policy specification is strictly for AND based policy
   only and may be extended at a later date with OR policy.  However,
   the ASN.1 for policy is formulated as CONS elements, leaving the



Bottomley               Expires 25 November 2021                [Page 5]

Internet-Draft              TPM 2 Key Format                    May 2021


   possibility of adding additional but optional elements for policy
   statements which are not supported by this standard (such as
   TPM2_PolicyAuthorize).

4.1.  TPMPolicy Syntax

    TPMPolicy ::= SEQUENCE {
       CommandCode   [0] EXPLICIT INTEGER
       CommandPolicy [1] EXPLICIT OCTET STRING
     }

   The Fields of type TPMPolicy have the following meanings:

4.1.1.  CommandCode

   This is the integer representation of the TPM command code for the
   policy statement.

4.1.2.  CommandPolicy

   This is a binary string representing a fully marshalled, TPM ordered,
   command body for the TPM policy command.  Therefore to send the
   command, the implementation simply marshalls the command code and
   appends this octet string as the body.

   Commands which have no body, such as TPM2_AuthVal, MUST be specified
   as a zero length OCTET STRING

4.2.  Policy Implementation Considerations

   The policy hash for AND based policies is constructed by extension of
   the prior policy hash

     newHash = HASH ( oldHash || policyHash )

   where policyHash is usually simply the hash of the fully marshalled
   policy command (including the CommandCode).  However, this isn't true
   for TPM2_PolicyCounterTimer() so always consult the [TPM2.0]
   specifications for how to construct the policyHash.

   The implementation should fail fast for policy problems, so if an
   individual policy command returns a failure (which usually indicates
   a particular policy requirement cannot be met), that failure should
   be reported in as much detail as possible and processing of the key
   should fail at that point.






Bottomley               Expires 25 November 2021                [Page 6]

Internet-Draft              TPM 2 Key Format                    May 2021


4.2.1.  Authorization Policy

   When Authorization (Passing in a password) is required, the emptyAuth
   parameter MUST be absent or set to false and additionally the
   TPM_CC_PolicyAuthValue MUST be specified as the command code for one
   entry in the TPMPolicy sequence.  However, the implementation MAY
   choose to execute either TPM2_PolicyPassword for TPM_RS_PW or
   TPM2_PolicyAuthValue for HMAC based authorization depending on
   whether the command being authorized is using sessions or not.  If
   the policy does not require an authorization then the emptyAuth
   parameter MUST be set to true.

5.  Implementation Considerations

   Implementations SHOULD support all TCG mandated algorithms, but MAY
   omit those deemed insecure, such as the SHA1 hash.

   TPM2_Import transforms the privKey into a TPM2B_PRIVATE which can
   then be used as a source to TPM2_Load, making the loading of
   importable keys is necessarily a two stage process, which can be time
   consuming on some TPMs.  Since the TPM2B_PRIVATE structure emitted by
   TPM2_Import is fully secure, Implementations SHOULD minimize the
   number of TPM2_Import operations by caching the emitted
   TPM2B_PRIVATE.

6.  Security Considerations

   The TPM 2.0 supports a variety of algorithms, the most common being
   SHA1 and SHA256 for hashing and RSA2048 and NIST P-256 for asymmetric
   keys.  Implementors SHOULD NOT use deprecated algorithms, such as
   SHA1, for any TPM operation.  In particular, the algorithm used for
   the policy hash SHOULD NOT be SHA1 and this means that SHA1 SHOULD
   NOT be used as the name algorithm hash for any TPM key.

   TPM 2.0 supports a session mode (TPM_RS_PW) where authorizations are
   passed to the TPM in clear text over the TPM connection.
   Implementations SHOULD consider the possibility of snooping on the
   wire between the implementation and the TPM, such as [TPM_GENIE], and
   SHOULD use HMAC session authorizations as best practice for all TPM
   keys.











Bottomley               Expires 25 November 2021                [Page 7]

Internet-Draft              TPM 2 Key Format                    May 2021


   In addition to snooping authorizations, snooping may also occur when
   key material is being exchanged between the TPM and the
   implementation, such as wrapping of private keys and the sealing and
   unsealing operations for sealed keys.  Implementations SHOULD always
   use HMAC sessions with TPMA_SESSION_DECRYPT when sensitive
   information is passed in to the TPM and HMAC sessions with
   TPMA_SESSION_ENCRYPT when sensitive information is received from the
   TPM.

   The easiest way to get the TPM to wrap an external private key is to
   use TPM2_Import.  However, since TPMA_SESSION_DECRYPT only protects
   the first parameter (which is encryptionKey), the duplicate should
   use inner symmetric encryption with a randomly generated ephemeral
   key, which is then presented to the TPM via the protected
   encryptionKey parameter.

   The TPM has a mode where it can generate private key material
   internally (using TPM2_Create) such that the private part of the key
   can never leave the TPM.  Implementations SHOULD support this mode
   but should be aware that while keys created like this may be more
   secure than wrapped keys, they can also be used only while access to
   the TPM that created them is available, so implementations SHOULD
   also support wrapping for keys that are expected to outlive the TPM
   that's using them.  Clients can then develop best practices around
   TPM wrapped identity keys, possibly with TPM created sub keys, which
   can only be used on the device they were wrapped for.

   Since TPM keys can only be used by the specific TPM that created
   them, which is usually embedded in a piece of hardware, they are
   secure against exfiltration attacks.  However, consideration should
   be given to an attacker gaining access to the system containing the
   TPM.  TPM keys are most secure when used as part of an operating
   system that has guaranteed trust properties, such as secure and
   measured boot.  Implementations SHOULD assist users in constructing
   key policies that ensure the key can be used only when the operating
   system is within its trusted parameters to minimize threats from co-
   located attackers.

7.  IANA Considerations

   None.

8.  Comments on and Enhancements to this Document

   Comments on this document should be addressed to the author
   (James.Bottomley@HansenPartnership.com) but should also CC the email
   lists of the two projects implementing this specification:




Bottomley               Expires 25 November 2021                [Page 8]

Internet-Draft              TPM 2 Key Format                    May 2021


   The OpenSSL engine: openssl_tpm2_engine@groups.io

   The Linux Kernel: linux-integrity@vger.kernel.org

   The OpenSSL TPM2 engine [OPENSSL_TPM2_ENGINE] is currently the only
   implementation of this full specification, so enhancements should be
   proposed after patches implementing the enhancement have been
   accepted by openssl_tpm2_engine or another full specification
   implementation.

9.  References

9.1.  Normative References

   [RFC2119]  Bradner, S., "Key words for use in RFCs to Indicate
              Requirement Levels", BCP 14, RFC 2119,
              DOI 10.17487/RFC2119, March 1997,
              <https://www.rfc-editor.org/info/rfc2119>.

   [RFC8017]  Moriarty, K., Ed., Kaliski, B., Jonsson, J., and A. Rusch,
              "PKCS #1: RSA Cryptography Specifications Version 2.2",
              RFC 8017, DOI 10.17487/RFC8017, November 2016,
              <https://www.rfc-editor.org/info/rfc8017>.

   [TPM2.0]   Trusted Computing Group, "TPM 2.0 Library Specification",
              15 March 2013,
              <https://trustedcomputinggroup.org/resource/tpm-library-
              specification/>.

   [X.680]    International Telecommunication Union, "ITU-T
              Recommendation X.680, Information technology - Abstract
              Syntax Notation One (ASN.1): Specification of basic
              notation.", August 2015,
              <https://itu.int/rec/T-REC-X.680-201508-I/en>.

9.2.  Informative References

   [TPM_GENIE]
              Boone, J., "TPM Genie: Interposer Attacks Against the
              Trusted Platform Module Serial Bus", 9 March 2018,
              <https://www.nccgroup.com/globalassets/about-
              us/us/documents/tpm-genie.pdf>.

   [OPENSSL_TPM2_ENGINE]
              Open Source Project, "OpenSSL TPM2 Engine",
              <https://git.kernel.org/pub/scm/linux/kernel/git/jejb/
              openssl_tpm2_engine.git/>.




Bottomley               Expires 25 November 2021                [Page 9]

Internet-Draft              TPM 2 Key Format                    May 2021


Author's Address

   James E.J. Bottomley
   Linux Kernel
   United States of America

   Email: James.Bottomley@HansenPartnership.com












































Bottomley               Expires 25 November 2021               [Page 10]
======

James Bottomley (1):
  doc: add draft RFC for TPM Key format

 Makefile.am                       |   2 +-
 configure.ac                      |   4 +-
 doc/Makefile.am                   |  15 +
 doc/draft-bottomley-tpm2-keys.xml | 465 ++++++++++++++++++++++++++++++
 4 files changed, 484 insertions(+), 2 deletions(-)
 create mode 100644 doc/Makefile.am
 create mode 100644 doc/draft-bottomley-tpm2-keys.xml

-- 
2.26.2

