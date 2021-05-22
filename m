Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9138D6E7
	for <lists+linux-integrity@lfdr.de>; Sat, 22 May 2021 20:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhEVSSB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 22 May 2021 14:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhEVSSA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 22 May 2021 14:18:00 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB33DC061574;
        Sat, 22 May 2021 11:16:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9AD591280257;
        Sat, 22 May 2021 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621707394;
        bh=cSfk9C4UwhilAgTZCJfqOQv8nUWGvajxGZD4aFG2Oe8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=XyElANYRCsJF4kaEDTWPyed1UuzNajVOfJGrS5cDxFPKkR/6abaAsZjD8fFs0kqmx
         7zU1L+gT4o0XeSuZ5ZRKSOamiaD6hWyYtb/uwwZ5IPiAfutITK//Xp6hyo8WD+LLLG
         nYgWtkQqDg2sVodtIr32zkYxB3S9n6jJJF2t2PGM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yx64k8rly-PC; Sat, 22 May 2021 11:16:34 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 27C0D1280245;
        Sat, 22 May 2021 11:16:34 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     openssl-tpm2-engine@groups.io
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 1/1] doc: add draft RFC for TPM Key format
Date:   Sat, 22 May 2021 11:15:48 -0700
Message-Id: <20210522181548.8284-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210522181548.8284-1-James.Bottomley@HansenPartnership.com>
References: <20210522181548.8284-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adds the xml file for the draft RFC and builds text and html versions
if the xml2rfc program is found.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 Makefile.am                       |   2 +-
 configure.ac                      |   4 +-
 doc/Makefile.am                   |  15 ++
 doc/draft-bottomley-tpm2-keys.xml | 329 ++++++++++++++++++++++++++++++
 4 files changed, 348 insertions(+), 2 deletions(-)
 create mode 100644 doc/Makefile.am
 create mode 100644 doc/draft-bottomley-tpm2-keys.xml

diff --git a/Makefile.am b/Makefile.am
index 33de0d9..787ba29 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -41,4 +41,4 @@ $(builddir)/%.1: $(srcdir)/%.1.in $(top_builddir)/%
 install-data-hook:
 	cd $(DESTDIR)$(openssl_enginedir) && $(LN_S) -f libtpm2@SHREXT@ tpm2@SHREXT@
 
-SUBDIRS = tests
+SUBDIRS = tests doc
diff --git a/configure.ac b/configure.ac
index 6efa7a5..e102dd2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -128,6 +128,8 @@ fi
 AC_PATH_PROG(TPMSERVER, tpm_server,,/bin:/usr/bin:/usr/lib/ibmtss:/usr/libexec/ibmtss)
 AC_PATH_PROG(SWTPM, swtpm,,/bin:/usr/bin:/usr/lib/ibmtss:/usr/libexec/ibmtss)
 AC_PATH_PROG(SWTPM_IOCTL, swtpm_ioctl,,/bin:/usr/bin:/usr/lib/ibmtss:/usr/libexec/ibmtss)
+AC_CHECK_PROG(XML2RFC, xml2rfc, xml2rfc)
+AM_CONDITIONAL(HAVE_XML2RFC, test -n "${XML2RFC}")
 CFLAGS="$CFLAGS -Wall"
 SHREXT=$shrext_cmds
 AC_SUBST(CFLAGS)
@@ -147,7 +149,7 @@ fi
 
 AC_SUBST(testtpm)
 
-AC_OUTPUT([Makefile tests/Makefile])
+AC_OUTPUT([Makefile tests/Makefile doc/Makefile])
 
 cat <<EOF
 
diff --git a/doc/Makefile.am b/doc/Makefile.am
new file mode 100644
index 0000000..0c24ce0
--- /dev/null
+++ b/doc/Makefile.am
@@ -0,0 +1,15 @@
+XML2RFC_TARGETS = draft-bottomley-tpm2-keys.txt \
+		draft-bottomley-tpm2-keys.html
+
+if HAVE_XML2RFC
+all: $(XML2RFC_TARGETS)
+
+clean-local:
+	rm -fr $(XML2RFC_TARGETS)
+endif
+
+$(builddir)/%.txt: $(srcdir)/%.xml
+	$(XML2RFC) --text -o $@ $<
+
+$(builddir)/%.html: $(srcdir)/%.xml
+	$(XML2RFC) --html -o $@ $<
diff --git a/doc/draft-bottomley-tpm2-keys.xml b/doc/draft-bottomley-tpm2-keys.xml
new file mode 100644
index 0000000..f18aa74
--- /dev/null
+++ b/doc/draft-bottomley-tpm2-keys.xml
@@ -0,0 +1,329 @@
+<?xml version="1.0"?>
+<!DOCTYPE rfc SYSTEM "rfc2629.dtd" [
+<!-- One method to get references from the online citation libraries.
+There has to be one entity for each item to be referenced.
+An alternate method (rfc include) is described in the references.
+-->
+<!ENTITY RFC2119 SYSTEM "http://xml.resource.org/public/rfc/bibxml/reference.RFC.2119.xml">
+<!ENTITY RFC8017 SYSTEM "http://xml.resource.org/public/rfc/bibxml/reference.RFC.8017.xml">
+]>
+<?rfc toc="yes" ?>
+<rfc ipr="trust200902" category="info" docName="draft-bottomley-tpm-keys-00">
+  <front>
+    <title abbrev="TPM 2 Key Format">ASN.1 Specification for TPM 2.0 Key Files</title>
+    <author initials="J." surname="Bottomley" fullname="James E.J. Bottomley">
+      <organization>Linux Kernel</organization>
+      <address>
+        <postal>
+          <street/>
+          <city/>
+          <region/>
+          <country>USA</country>
+        </postal>
+        <email>James.Bottomley@HansenPartnership.com</email>
+      </address>
+    </author>
+    <date month="May" year="2021"/>
+    <area>Security</area>
+    <keyword>I-D</keyword>
+    <keyword>Internet-Draft</keyword>
+    <keyword>X.509</keyword>
+    <abstract>
+      <t>
+	This specification is designed ot be an extension to the ASN.1
+	(defined in <xref target="X.680"/>) specification of PKCS #1
+	<xref target="RFC8017"/> to define the file format of private
+	keys that need to be loaded into a TPM 2 device to operate.
+      </t>
+    </abstract>
+  </front>
+  <middle>
+    <section anchor="intro" title="Introduction">
+      <t>
+	The Security of private keys has long been a concern and the
+	ability of ubiquitous devices like TPMs has made it useful to
+	use them for secure private key storage.  With the advent of
+	TPM 2.0, private key storage inside the TPM (acting as a token
+	which could be referred to by PKCS #11) has been discouraged,
+	and instead key files which are loaded and evicted as
+	necessary is the encouraged format.  This standard defines an
+	interoperable ASN.1 representation for such key files, so that
+	a key created by one tool should be loadable by a different
+	one.
+      </t>
+    </section>
+    <section anchor="terms" title="Terminology">
+      <t>
+        The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
+        NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and
+        "OPTIONAL" in this document are to be interpreted as described in
+        <xref target="RFC2119"/>.
+      </t>
+      <section title="Notation">
+	<dl>
+	  <dt>ASN.1</dt>
+	  <dd>Abstract Syntax Notatition defined in
+	  <xref target="X.680"/></dd>
+	  <dt>DER</dt>
+	  <dd>Distinguished Encoding Rules. Basically a defined binary
+	  representation for ASN.1</dd>
+	  <dt>MSO</dt>
+	  <dd>Most Significant Octet (the highest order
+	  byte of an integer)</dd>
+	  <dt>PEM</dt>
+	  <dd>Privacy enhanced Electronic Mail.  An ASCII compatible
+	  representation of DER</dd>
+	  <dt>TCG</dt>
+	  <dd>Trusted Computing Group</dd>
+	  <dt>TPM</dt>
+	  <dd>Trusted Platform Module</dd>
+	</dl>
+      </section>
+    </section>
+    <section anchor="keyrep" title="Key Representation">
+      <t>
+	All TPM 2.0 keys consist of two binary pieces, a public part,
+	which can be parsed according to the TPM specification for
+	TPM2B_PUBLIC <xref target="TPM2.0"/> and a private part, which
+	is cryptographically sealed in such a way as to be only
+	readable on the TPM that created it.  The purpose of this
+	specification is to specify a format by which the public and
+	private pieces of a TPM key can be loaded.
+      </t>
+      <t>
+	The design of the TPMkey ASN.1 format is that it should have a
+	distinguishing OID at the beginning so the DER/BER form of the
+	key can be easily recognized.  In PEM form, the key MUST have
+	"-----BEGIN TSS2 PRIVATE KEY-----" and "-----END TSS2 PRIVATE
+	KEY-----" as the PEM guards. All additional information that
+	may be needed to load the key is specified as optional
+	explicit elements, which can be extended by later
+	specifications, which is why the TPMkey is not versioned.
+      </t>
+      <section anchor="tpmkey" title="TPMkey Syntax">
+	<figure><artwork>
+ TPMKey ::= SEQUENCE {
+    type        OBJECT IDENTIFIER
+    emptyAuth   [0] EXPLICIT BOOLEAN OPTIONAL
+    policy      [1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL
+    secret      [2] EXPLICIT OCTET STRING OPTIONAL
+    parent      INTEGER
+    pubkey      OCTET STRING
+    privkey     OCTET STRING
+  }
+	</artwork></figure>
+	<t>
+	  The fields of type TPMKey have the following meanings:
+	</t>
+	<section title="type">
+	  <t>
+	    A unique OID specifying the key type.  This standard
+	    currently defines three types of keys: a loadable key,
+	    specified by id-loadablekey, (to be loaded with
+	    TPM2_Load), an importable key, specified by
+	    id-importablekey, (to be loaded with TPM2_Import) and a
+	    sealed data key, specified by id-sealedkey, (to be
+	    extracted with TPM2_Unseal).  The TCG has reserved the
+	    following OID prefix for this:
+	  </t>
+	  <figure><artwork>
+  id-tpmkey OBJECT IDENTIFIER ::=
+    {joint-iso-itu-t(2) international-organizations(23) 133 10}
+	  </artwork></figure>
+	  <t>
+	    And the three key types are:
+	  </t>
+	  <figure><artwork>
+  id-loadablekey OBJECT IDENTIFIER ::=
+    {id-tpmkey 3}
+	  </artwork></figure>
+	  <figure><artwork>
+  id-importablekey OBJECT IDENTIFIER ::=
+    {id-tpmkey 4}
+	  </artwork></figure>
+	  <figure><artwork>
+  id-sealedkey OBJECT IDENTIFIER ::=
+    {id-tpmkey 5}
+	  </artwork></figure>
+	</section>
+	<section title="emptyAuth">
+	  <t>
+	    An implementation needs to know as it formulates the
+	    TPM2_Load/Import/Unseal command whether it must also send
+	    down an authorization, so this parameter gives that
+	    indication.  emptyAuth MUST be true if authorization is
+	    NOT required and MUST BE either false or absent if
+	    authorization is required.  Since this element has
+	    three states (one representing true and two representing
+	    false) it is RECOMMENDED that implementations emitting
+	    TPMkey representations use absence of the tag to represent
+	    false.  However, implementations reading TPMKey MUST
+	    be able to process all three possible states.
+	  </t>
+	</section>
+	<section title="policy">
+	  <t>
+	    This MUST be present if the TPM key has a policy hash
+	    because it describes to the implementation how to
+	    construct the policy.  The forms of the policy statement
+	    are described in section <xref target="policy"/>.
+	  </t>
+	</section>
+	<section title="secret">
+	  <t>
+	    This section describes the additional cryptographic
+	    secret used to specify the outer wrapping of an
+	    importable key.  It MUST be present for key type
+	    id-importablekey and MUST NOT be present for any other
+	    key type.
+	  </t>
+	</section>
+	<section title="parent">
+	  <t>
+	    This MUST be present for all keys and specifies the parent
+	    key.  The parent key SHOULD be either a persistent handle
+	    (MSO 0x81) or a permanent handle (MSO 0x40).  Since
+	    volatile handle numbering can change unexpectedly
+	    depending on key load order, the parent SHOULD NOT be a
+	    volatile handle (MSO 0x80). The parent MAY NOT be any
+	    other MSO.
+	  </t>
+	  <t>
+	     If a permanent handle (MSO 0x40) is specified then the
+	     implementation MUST run TPM2_CreatePrimary on the handle
+	     using the TCG specified Elliptic Curve template for the
+	     NIST P-256 curve and use the primary key so generated as
+	     the parent.
+	  </t>
+	</section>
+	<section title="pubkey">
+	  <t>
+	    This MUST be present and MUST correspond to the fully
+	    marshalled TPM2B_PUBLIC structure of the TPM Key with the
+	    exception that the leading U16 parameter specifying size
+	    MUST BE omitted (it is redundant, since all ASN.1
+	    structures are length specified).
+	  </t>
+	</section>
+	<section title="privkey">
+	  <t>
+	    This MUST be present and MUST correspond to the fully
+	    marshalled TPM2B_PRIVATE structure of the TPM Key with the
+	    exception that the leading U16 parameter specifying size
+	    MUST BE omitted (it is redundant, since all ASN.1
+	    structures are length specified).
+	  </t>
+	</section>
+      </section>
+    </section>
+    <section anchor="policy" title="Key Policy Specification">
+      <t>
+	Policy is constructed on a TPM by executing a sequence of
+	policy statements.  This specification currently only defines
+	a limited subset of the allowed policy statements.  The policy
+	is specified by a hash, which the execution of the policy
+	statements must reach in order for the policy to be validated
+	(See <xref target="TPM2.0"/> Part 1 for a detailed description.
+      </t>
+      <t>
+	The TPMPolicy ASN.1 MUST be a sequence of policy statements
+	which correspond exactly to TPM policy instructions in the
+	order they should be executed and additionally from which the
+	ultimate policy hash can be constructed.
+      </t>
+      <t>
+	The current policy specification is strictly for AND based
+	policy only and may be extended at a later date with OR
+	policy.  However, the ASN.1 for policy is fomulated as CONS
+	elements, leaving the possibility of adding additional but
+	optional elements for policy statements which are not
+	supported by this standard (such as TPM2_PolicyAuthorize).
+      </t>
+      <section title="TPMPolicy Syntax">
+	<figure><artwork>
+ TPMPolicy ::= SEQUENCE {
+    CommandCode   [0] EXPLICIT INTEGER
+    CommandPolicy [1] EXPLICIT OCTET STRING
+  }
+	</artwork></figure>
+	<t>
+	  The Fields of type TPMPolicy have the following meanings:
+	</t>
+	<section title="CommandCode">
+	  <t>
+	    This is the integer representation of the TPM command code
+	    for the policy statement.
+	  </t>
+	</section>
+	<section title="CommandPolicy">
+	  <t>
+	    This is a binary string representing a fully marshalled,
+	    TPM ordered, command body for the TPM policy command.
+	    Therefore to send the command, the implementation simply
+	    marshalls the command code and appends this octet string
+	    as the body.
+	  </t>
+	  <t>
+	    Commands which have no body, such as TPM2_AuthVal, MUST be
+	    specified as a zero length OCTET STRING
+	  </t>
+	</section>
+      </section>
+      <section title="Policy Implementation Considerations">
+	<t>
+	  The policy hash for AND based policies is constructed by extension of the prior policy hash
+	</t>
+	<figure><artwork>
+  newHash = HASH ( oldHash || policyHash )
+	</artwork></figure>
+	<t>
+	  where policyHash is usually simply the hash of the fully
+	  marshalled policy command (including the CommandCode).
+	  However, this isn't true for TPM2_PolicyCounterTimer() so
+	  always consult the <xref target="TPM2.0"/> specifications
+	  for how to construct the policyHash.
+	</t>
+	<section title="Authorization Policy">
+	  <t>
+	    When Authorization (Passing in a password) is required,
+	    the emptyAuth parameter MUST be absent or set to false
+	    and additionally the TPM_CC_PolicyAuthValue MUST be
+	    specified as the command code for one entry in the
+	    TPMPolicy sequence.  However, the implementation MAY
+	    choose to execute either TPM2_PolicyPassword for TPM_RS_PW
+	    or TPM2_PolicyAuthValue for HMAC based authorization
+	    depending on whether the command being authorized is using
+	    sessions or not.  If the policy does not require an
+	    authorization then the emptyAuth parameter MUST be set to
+	    true.
+	  </t>
+	</section>
+      </section>
+    </section>
+
+  </middle>
+  <back>
+    <references title="Normative References">
+      &RFC2119;
+      &RFC8017;
+      <reference anchor="TPM2.0" target="https://trustedcomputinggroup.org/resource/tpm-library-specification/">
+	<front>
+          <title>TPM 2.0 Library Specification</title>
+          <author initials="." surname="TCG" fullname="Trusted Computing Group">
+            <organization/>
+          </author>
+          <date year="2013" month="March" day="15"/>
+	</front>
+      </reference>
+      <reference anchor="X.680" target="https://www.itu.int/rec/T-REC-X.680-201508-I/en">
+	<front>
+	  <title>ITU-T Recommendation X.680,
+              Information technology - Abstract Syntax Notation One
+          (ASN.1):  Specification of basic notation.</title>
+	  <author><organization>ITU</organization></author>
+	  <date year="2015" month="August"/>
+	</front>
+      </reference>
+    </references>
+  </back>
+</rfc>
-- 
2.26.2

